CREATE OR REPLACE FUNCTION fn_inventory_type_list (
	p_current_uid character varying(255),
	p_is_in_use integer,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	inventory_type_id uuid,
	inventory_type_desc character varying(255)
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/* 0100_0085_fn_inventory_type_list
	
	SELECT * from fn_inventory_type_list (
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
			SELECT a.inventory_type_id, a.inventory_type_desc
			FROM tb_inventory_type a
			ORDER BY a.display_seq, a.inventory_type_desc
		);
	
	ELSE
	
		RETURN QUERY (
			SELECT a.inventory_type_id, a.inventory_type_desc
			FROM tb_inventory_type a
			WHERE a.is_in_use = p_is_in_use
			ORDER BY a.display_seq, a.inventory_type_desc
		);
	
	END IF;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$$;