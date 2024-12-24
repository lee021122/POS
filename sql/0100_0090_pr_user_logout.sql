CREATE OR REPLACE PROCEDURE pr_user_logout (
	IN p_sess_id uuid,
	OUT p_msg text,
	IN p_is_debug integer DEFAULT 0
) 
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_now CONSTANT timestamp = current_timestamp;
	audit_log text;
	module_code text;
	v_login_id text;
	v_user_id uuid;
BEGIN
/*

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_user_logout - start';
	END IF;
	
	module_code := 'User Access - User Logout';

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF NOT EXISTS (
		SELECT *
		FROM tb_user_access_log
		WHERE sess_id = p_sess_id
	) THEN
		p_msg := 'Logout Failed!!';
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	UPDATE tb_user_access_log 
	SET logout_on = v_now
	WHERE sess_id = p_sess_id;
	
	SELECT login_id, user_id
	INTO v_login_id, v_user_id
	FROM tb_user_access_log
	WHERE sess_id = p_sess_id;
	
	p_msg := 'ok';
	
	audit_log := v_login_id || 'has been logout the system.';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_user_logout'
		, p_uid => v_login_id
		, p_id1 => v_user_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	); 
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_user_logout - end';
	END IF;
	
END
$BODY$;