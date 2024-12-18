CREATE OR REPLACE FUNCTION fn_printer_type_list (
	p_current_uid character varying(255),
	p_is_in_use integer,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	printer_type_id integer,
	printer_type character varying(255)
) 
LANGUAGE 'plpgsql'
AS $$
DECLARE

BEGIN
/* 0100_0087_fn_printer_type_list

	select * from fn_printer_type_list (
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
			SELECT a.printer_type_id, a.printer_type
			FROM tb_pos_printer_type a
			ORDER BY a.display_seq, a.printer_type
		);
	
	ELSE
	
		RETURN QUERY (
			SELECT a.printer_type_id, a.printer_type
			FROM tb_pos_printer_type a
			WHERE a.is_in_use = p_is_in_use
			ORDER BY a.display_seq, a.printer_type
		);
	
	END IF;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$$;