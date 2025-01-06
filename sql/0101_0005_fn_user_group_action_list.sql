CREATE OR REPLACE FUNCTION fn_user_group_action_list (
	p_current_uid character varying(255),
	p_user_group_id integer,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	user_group_id integer,
	user_group_desc character varying(255),
	action_id uuid,
	group_code text,
	action_desc text,
	is_in_use integer,
	display_seq character varying(6)
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/* 0101_0005_fn_user_group_action_list

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	RETURN QUERY (
		SELECT a.user_group_id, a.user_group_desc, c.action_id, c.group_code, c.action_desc, a.is_in_use, a.display_seq
		FROM tb_user_group a
		INNER JOIN tb_user_group_action b ON b.user_group_id = a.user_group_id
		INNER JOIN tb_action c ON c.action_id = b.action_id
		WHERE a.user_group_id = p_user_group_id
		ORDER BY a.display_seq, a.user_group_desc, c.group_code, c.action_desc
	);

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$$;