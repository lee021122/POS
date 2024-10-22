CREATE OR REPLACE PROCEDURE pr_meal_period_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	INOUT p_meal_period_id uuid,
	IN p_meal_period_desc character varying(255),
	IN p_is_in_use integer,
	IN p_display_seq character varying(6),
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_now CONSTANT timestamp = localtimestamp;
	audit_log text;
	module_code text;
	v_meal_period_desc_old character varying(255);
	v_is_in_use_old integer;
	v_display_seq_old character varying(255);
BEGIN
/* 0100_0004_pr_meal_period_save

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_meal_period_save - start';
	END IF;
	
	module_code := 'Settings - Meal Period';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF LENGTH(COALESCE(p_meal_period_desc, '')) = 0 THEN
		p_msg := 'Meal Period Description cannot be blank!!';
		RETURN;
	END IF;
	
	IF EXISTS (
		SELECT *
		FROM tb_meal_period
		WHERE 
			meal_period_desc = p_meal_period_desc
			AND meal_period_id <> fn_to_guid(p_meal_period_id)
	) THEN
		p_msg := 'Meal Period Description: ' || p_meal_period_desc || ' already exists!!';
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF fn_to_guid(p_meal_period_id) = fn_empty_guid() THEN
		
		p_meal_period_id := gen_random_uuid();
		
		-- Insert new record
		INSERT INTO tb_meal_period (
			meal_period_id, created_on, created_by, modified_on, modified_by, meal_period_desc,
			is_in_use, display_seq
		) VALUES (
			p_meal_period_id, v_now, p_current_uid, v_now, p_current_uid, p_meal_period_desc,
			p_is_in_use, p_display_seq
		);
		
		-- Prepare Audit Log
		audit_log := 'Added Meal Period: ' || p_meal_period_desc || '.';
		
	ELSE
	
		-- Get old record for audit log purpose
		SELECT meal_period_desc, is_in_use, display_seq
		INTO v_meal_period_desc_old, v_is_in_use_old, v_display_seq_old
		FROM tb_meal_period
		WHERE meal_period_id = p_meal_period_id;
		
		-- Update Record
		UPDATE tb_meal_period
		SET
			modified_on = v_now,
			modified_by = p_current_uid,
			meal_period_desc = p_meal_period_desc,
			is_in_use = p_is_in_use,
			display_seq = p_display_seq
		WHERE meal_period_id = p_meal_period_id;
		
		-- Prepare Audit Log
		audit_log := 'Updatetd Meal Period Description from ' || v_meal_period_desc_old || ' to ' || p_meal_period_desc || ', ' ||
						'Updatetd Is in Use from ' || v_is_in_use_old || ' to ' || p_is_in_use || ', ' ||
						'Updatetd Display Sequence from ' || v_display_seq_old || ' to ' || p_display_seq || '.';
		
	END IF;
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_meal_period_save'
		, p_uid => p_current_uid
		, p_id1 => p_meal_period_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	);
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_meal_period_save - end';
	END IF;
	
END
$BODY$;