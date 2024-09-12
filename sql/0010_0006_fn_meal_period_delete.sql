CREATE OR REPLACE FUNCTION public.fn_meal_period_delete(
	p_current_uid character varying,
	p_meal_period_id uuid,
	p_is_debug integer DEFAULT 0)
    RETURNS TABLE(msg text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_now CONSTANT timestamp = localtimestamp;
	v_msg text;
	audit_log text;
	module_code text;
    v_meal_period_id_old uuid;
	v_meal_period_desc_old character varying;
BEGIN
/**
0010_0006_fn_meal_period_delete

-- Delete Meal Period

select * 
from fn_meal_period_delete (
	p_current_uid => 'tester',
	p_meal_period_id => '1412a87d-ec29-4ed7-8799-9e669a1969f2',
);

*/
	
    IF p_is_debug = 1 THEN
		RAISE NOTICE 'fn_meal_period_delete - start';
	END IF;
	
	module_code = 'Settings - Meal Period';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- Get old record for audit log purpose
	SELECT meal_period_desc
    INTO v_meal_period_desc_old
    FROM tb_meal_period
    WHERE meal_period_id = p_meal_period_id;
	
	IF NOT EXISTS (
		SELECT *
		FROM tb_meal_period
		WHERE 
			meal_period_id= p_meal_period_id
	) THEN
		RETURN QUERY (
			SELECT 'Meal Period: ' || v_meal_period_desc_old || ' is not exists!!'msg
		);
		RETURN;
	END IF;
	
	IF EXISTS (
		SELECT *
		FROM tb_food_menu
		WHERE 
			meal_period_id = p_meal_period_id 
	) THEN
		RETURN QUERY(
			SELECT 'Meal Period: ' || v_meal_period_desc_old || ' is in used!!' msg
		);
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	-- Delete the record
	DELETE FROM tb_meal_period
	WHERE meal_period_id = p_meal_period_id;
	
	audit_log = 'Delete Meal Period: ' || v_meal_period_desc_old;
	
	CALL pr_append_sys_task_inbox (
		p_msg => audit_log
		, p_remarks => 'fn_meal_period_delete'
		, p_uid => p_current_uid
		, p_id1 => p_meal_period_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => 'AR'
		, p_module_code => module_code
	);
		
	v_msg = 'ok';
	
	-- -------------------------------------
	-- return message
	-- -------------------------------------
	RETURN QUERY(
		SELECT 
			v_msg AS msg
	);
	RETURN;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'fn_meal_period_delete - end';
	END IF;

END;
$BODY$;
