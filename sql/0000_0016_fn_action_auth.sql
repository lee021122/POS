CREATE OR REPLACE FUNCTION fn_action_auth (
	p_action_code character varying(255),
	p_rid integer
) RETURNS INTEGER
LANGUAGE 'plpgsql'
AS $$
DECLARE
	is_auth integer;
BEGIN
/* -- Check action user authentication
	SELECT * FROM fn_action_auth('prod-category::s', 1)
*/

	SELECT is_default_func
	INTO is_auth
	FROM tb_action a
	LEFT JOIN tb_user_group_action b ON b.action_id = a.action_id
	WHERE 
		a.action_code = p_action_code
		AND b.user_group_id = p_rid;
	
	RETURN COALESCE(is_auth, -99);

END
$$;