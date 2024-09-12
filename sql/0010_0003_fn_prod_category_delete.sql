-- FUNCTION: public.fn_prod_category_delete(character varying, uuid, integer)

-- DROP FUNCTION IF EXISTS public.fn_prod_category_delete(character varying, uuid, integer);

CREATE OR REPLACE FUNCTION public.fn_prod_category_delete(
	p_current_uid character varying,
	p_category_id uuid,
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
	v_category_desc_old varchar(255);
	v_module_code text;
	audit_log text;
BEGIN
/**
0010_0003_fn_prod_category_delete

-- Delete category

select * 
from fn_prod_category_delete (
	p_current_uid => 'tester',
	p_category_id => null,
	p_category_desc => 'Drinks',
	p_is_in_use => 1,
	p_display_seq => '000001'
);

*/

    IF p_is_debug = 1 THEN
		RAISE NOTICE 'fn_prod_category_delete - start';
	END IF;
	
	v_module_code = 'Settings - Category';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF NOT EXISTS (
		SELECT *
		FROM tb_prod_category 
		WHERE category_desc = p_category_desc
	) THEN
		RETURN QUERY (
			SELECT 'Category Code: ' || p_category_desc || ' is not exists!!'msg, null AS category_id
		);
		RETURN;
	END IF;
	
	IF EXISTS (
		SELECT *
		FROM tb_product
		where
			category_id = p_category_id
	) THEN
		RETURN QUERY(
		 SELECT 'The Category is in used!!' AS msg, NULL AS category_id
		);
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	-- Get old record for audit log purpose
	SELECT category_desc
    INTO v_category_desc_old
    FROM tb_prod_category
    WHERE category_id = p_category_id;
	
	-- Delete the record
	DELETE FROM tb_prod_category
	WHERE category_id = p_catgeory_id;
	
	audit_log = 'Delete Category: ' || v_category_desc_old;
	
	CALL pr_sys_append_audit_log (
		p_msg => v_msg
		, p_remarks => 'fn_prod_category_delete'
		, p_uid => p_current_uid
		, p_id1 => p_category_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => v_module_code
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
		RAISE NOTICE 'fn_prod_category_delete - end';
	END IF;

END;
$BODY$;

ALTER FUNCTION public.fn_prod_category_delete(character varying, uuid, integer)
    OWNER TO leehao;
