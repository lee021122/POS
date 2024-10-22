CREATE OR REPLACE FUNCTION fn_prod_category_list (
	p_current_uid character varying(255),
	p_is_in_use integer,
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	category_id uuid,
    category_desc character varying(255),
    is_in_use integer,
    display_seq character varying(6),
    modified_by character varying(255)
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/* 0100_0002_fn_prod_category_list

	SELECT * FROM fn_prod_category_list ('tester', 1);

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	IF COALESCE(p_is_in_use, -1) = -1 THEN 
		
		RETURN QUERY (
			SELECT a.category_id, a.category_desc, a.is_in_use, a.display_seq, a.modified_by
			FROM tb_prod_category a
			ORDER BY
				a.display_seq, a.category_desc
		);
	
	ELSE 
	
		RETURN QUERY (
			SELECT a.category_id, a.category_desc, a.is_in_use, a.display_seq, a.modified_by
			FROM tb_prod_category a
			WHERE a.is_in_use = 1
			ORDER BY
				a.display_seq, a.category_desc
		);
	
	END IF;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;