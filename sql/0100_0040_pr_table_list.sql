CREATE OR REPLACE FUNCTION fn_table_list (
	p_current_uid character varying(255),
	p_is_in_use integer,
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	table_id uuid,
	modified_on timestamp,
	modified_by character varying(255),
	table_desc character varying(255),
	is_in_use integer,
	display_seq character varying(6)
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/* 0100_0040_pr_table_list

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF p_is_in_use = -1 THEN 
	
		SELECT a.table_id, a.modified_on, a.modified_by, a.table_desc, a.is_in_use, a.display_seq
		FROM tb_table a
		ORDER BY 
			a.display_seq, a.table_desc;
	
	ELSE
	
		SELECT a.table_id, null AS modified_on, null AS modified_by, a.table_desc, null AS is_in_use, null AS display_seq
		FROM tb_table_section a
		WHERE is_in_use = p_is_in_use
		ORDER BY 
			a.display_seq, a.table_desc;
	
	END IF;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;