CREATE OR REPLACE PROCEDURE pr_pymt_mode_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	INOUT p_pymt_mode_id uuid,
	IN p_pymt_mode_desc character varying(255),
	IN p_pymt_type uuid,
	IN p_for_store text,
	IN p_is_in_use integer,
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
	v_pymt_mode_desc_old character varying(255);
	v_pymt_type_old uuid;
	v_for_store_old text;
	v_is_in_use_old integer;
BEGIN
/* 0100_0024_pr_pymt_mode_save 

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_pymt_mode_save - start';
	END IF;
	
	module_code := 'Settings - Payment Mode';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF LENGTH(COALESCE(p_pymt_mode_desc, '')) = 0 THEN
		p_msg := 'Payment Mode cannoto be blank!!';
		RETURN;
	END IF;
	
	IF EXISTS (
		SELECT *
		FROM tb_pymt_mode
		WHERE 
			pymt_mode_desc = p_pymt_mode_desc
			AND pymt_mode_id <> fn_to_guid(p_pymt_mode_id)
	) THEN
		p_msg := 'Payment Mode: ' || p_pymt_mode_desc || ' already exists!!';
		RETURN;
	END IF;
	
	IF LENGTH(COALESCE(p_for_store)) = 0 THEN
		p_msg := 'Please Select the Store!!';
		RETURN;
	END IF;	
	
	-- -------------------------------------
    -- create and use temporary table
    -- -------------------------------------
    CREATE TEMPORARY TABLE for_store_tb (
        for_store_id uuid
    );
	
	INSERT INTO for_store_tb (for_store_id) 
	VALUES (
		 CAST(UNSET(string_to_array(p_for_store, ';;')) AS uuid)
	);
	
	IF NOT EXISTS (
		SELECT *
		FROM tb_store a
		INNER JOIN for_store_tb b ON b.for_store_id = a.store_id
	) THEN
		p_msg := 'Invalid Store Name!!';
		RETURN;
	END IF;
	
	IF LENGTH(COALESCE(p_pymt_type)) = 0 THEN
		p_msg := 'Please Select the Type!!';
		RETURN;
	END IF;	
	
	IF NOT EXISTS (
		SELECT *
		FROM tb_sys_pymt_type
		WHERE sys_pymt_type_id = p_pymt_type
	) THEN 
		p_msg := 'Invalid Type!!';
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF fn_to_guid(p_pymt_mode_id) = fn_empty_guid() THEN
	
		p_pymt_mode_id := gen_random_uuid();
		
		-- Insert new record
		INSERT INTO tb_pymt_mode (
			pymt_mode_id, created_on, created_by, modified_on, modified_by, pymt_mode_desc, 
			pymt_type, for_store, is_in_use 
		) VALUES (
			p_pymt_mode_id, v_now, p_current_id, v_now, p_current_uid, p_pymt_mode_desc,
			p_pymt_type, p_for_store, COALESCE(p_is_in_use, 0)
		);
		
		-- Prepare Audit Log
		audit_log := 'Added New Payment Mode: ' || p_pymt_mode_desc || '.';
	
	ELSE
		
		-- Get old record for audit log purpose
		SELECT pymt_mode_desc, pymt_type, for_store, is_in_use 
		INTO v_pymt_mode_desc_old, v_pymt_type_old, v_for_store_old, v_is_in_use_old
		FROM tb_payment_mode
		WHERE pymt_mode_id = p_pymt_mode_id;
		
		-- Update the Record
		UPDATE tb_pymt_mode
		SET	
			modified_on = v_now,
			modified_by = p_current_uid,
			pymt_mode_desc = p_pymt_mode_desc, 
			pymt_type = p_pymt_type, 
			for_store = p_for_store, 
			is_in_use = COALESCE(p_is_in_use, 0)
		WHERE pymt_mode_id = p_pymt_mode_id;
		
		-- Prepare Audit Log
		audit_log := 'Updated Payment Mode Description from ' || v_pymt_mode_desc_old || ' to ' || p_pymt_mode_desc || ', ' ||
						'Updated Type from ' || v_pymt_type_old || ' to ' || p_pymt_type || ', ' ||
						'Updated Is in Use from ' || v_is_in_use_old || ' to ' || p_is_in_use || '.';
 	
	END IF;
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_pymt_mode_save'
		, p_uid => p_current_uid
		, p_id1 => p_pymt_mode_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	);
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_pymt_mode_save - end';
	END IF;
	
	DROP TABLE for_store_tb;
	
END
$BODY$;