CREATE OR REPLACE FUNCTION fn_user_group_list (
	p_current_uid character varying(255),
	p_is_in_use integer,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	user_group_id integer,
	modified_on timestamp,
	modified_by character varying(255),
	user_group_desc character varying(255),
	--action_desc text,
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
/* 
	select * from fn_user_group_list (
		'tester',
		-1,
		null,
		null,
		null
	);
*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF COALESCE(p_is_in_use, -1) = -1 THEN
		
		RETURN QUERY (
			SELECT a.user_group_id, a.modified_on, a.modified_by, a.user_group_desc, a.is_in_use, a.display_seq
			FROM tb_user_group a
-- 			INNER JOIN tb_user_group_action b ON b.user_group_id = a.user_group_id
-- 			INNER JOIN tb_action c ON c.action_id = b.action_id
			WHERE a.user_group_id <> '-999'
			ORDER BY a.display_seq, a.user_group_desc  --, c.group_code, c.action_desc
		);
		
	ELSE
	
		RETURN QUERY (
			SELECT 
				a.user_group_id, null::timestamp AS modified_on, null::character varying AS modified_by, a.user_group_desc, null::integer AS is_in_use, 
				null::character varying AS display_seq
			FROM tb_user_group a
-- 			INNER JOIN tb_user_group_action b ON b.user_group_id = a.user_group_id
-- 			INNER JOIN tb_action c ON c.action_id = b.action_id
			WHERE 
				a.user_group_id <> '-999'
				AND a.is_in_use = p_is_in_use
			ORDER BY a.display_seq, a.user_group_desc --, c.group_code, c.action_desc
		);
	
	END IF;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$$;