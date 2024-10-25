CREATE OR REPLACE PROCEDURE pr_general_setting_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_setting_title character varying(255),
	IN p_setting_value character varying(255),
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	audit_log text;
	module_code text;
	v_setting_title character varying(255);
	v_setting_value character varying(255);
BEGIN
/* 0100_0020_pr_general_setting_save
-- 


*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_general_setting_save - start';
	END IF;
	
	module_code := 'Settings - General Setting';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF NOT EXISTS (
		SELECT sys_setting_title
		FROM tb_sys_setting
		WHERE sys_setting_title = p_setting_title
	) THEN
		p_msg := 'Invalid Setting!!';
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	-- Get old record for audit log purpose
	SELECT sys_setting_title, sys_setting_value
	INTO v_setting_title, v_setting_value
	FROM tb_sys_setting
	WHERE sys_setting_title = p_setting_title;
	
	UPDATE tb_sys_setting
	SET 
		sys_setting_value = p_setting_value
	WHERE sys_setting_title = p_setting_title;
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_general_setting_save'
		, p_uid => p_current_uid
		, p_id1 => p_setting_title
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	); 
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_general_setting_save - end';
	END IF;

END
$BODY$;