CREATE OR REPLACE PROCEDURE pr_general_setting_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_setting_grp character varying(255),
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
	v_setting_grp character varying(255);
	v_setting_title character varying(255);
	v_setting_value character varying(255);
BEGIN
/* 0100_0020_pr_general_setting_save
-- Seting only update is_in_use from 0 to 1 only


*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_general_setting_save - start';
	END IF;
	
	module_code := 'Settings - General Setting';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_general_setting_save - end';
	END IF;

END
$BODY$;