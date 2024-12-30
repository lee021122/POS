CREATE OR REPLACE FUNCTION fn_get_user_sess (
	IN p_login_id text,
	IN p_sess_id uuid,
	IN p_is_debug integer DEFAULT 0
) RETURNS TEXT 
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_user_id uuid;
	p_msg text;
BEGIN
/* -- Check user session is valid or not

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	SELECT user_id
	INTO v_user_id
	FROM tb_users
	WHERE login_id = p_login_id;
	
	IF NOT EXISTS (
		SELECT sess_id
		FROM tb_user_access_log
		WHERE 
			user_id = v_user_id
			AND logout_on IS NULL
		ORDER BY user_access_log_id DESC
		LIMIT 1
	) THEN
		p_msg := 'Invalid Session!!';
	ELSE 
		p_msg := 'ok';
	END IF;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$$;