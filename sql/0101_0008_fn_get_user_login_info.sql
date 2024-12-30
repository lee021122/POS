CREATE OR REPLACE FUNCTION fn_get_user_login_info (
	p_sess_id uuid
) RETURNS TABLE (
	login_id text,
	gg integer,
	iidd uuid
)
LANGUAGE 'plpgsql'
AS $$
DECLARE

BEGIN
/*

*/

	RETURN QUERY (
		SELECT a.login_id, a.user_group_id AS gg, a.user_id AS iidd
		FROM tb_user_access_log a
		WHERE a.sess_id = p_sess_id
	);

END
$$;