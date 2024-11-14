CREATE OR REPLACE FUNCTION fn_modifier_group_list (
	p_current_uid character varying(255),
	p_rid character varying(255),
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	modifier_group_id uuid,
	modified_on timestamp,
	modified_by character varying(255),
	modifier_group_name character varying(255),
	is_single_modifier_choice integer,
	is_multiple_modifier_choice integer
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
BEGIN
/* 0100_0011_fn_modifier_group_list
	
	SELECT * from fn_modifier_group_list ('tester', '', '', '');
	
*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	RETURN QUERY (
		SELECT a.modifier_group_id, a.modified_on, a.modified_by, a.modifier_group_name, a.is_single_modifier_choice, a.is_multiple_modifier_choice
		FROM tb_modifier_group a
		ORDER BY a.modifier_group_name
	);

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
END
$$;
