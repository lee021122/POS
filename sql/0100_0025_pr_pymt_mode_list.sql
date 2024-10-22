CREATE OR REPLACE FUNCTION fn_pymt_mode_list (
	p_current_uid character varying(255),
	p_is_in_use integer,
	p_store_id uuid,
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	pymt_mode_id uuid,
	modified_on timestamp,
	modified_by character varying(255),
	pymt_mode_desc character varying(255),
	pymt_type_id integer,
	store_name character varying(255),
	is_in_use integer
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/* 0100_0025_pr_pymt_mode_list 
	
	SELECT * from fn_pymt_mode_list('tester', 1, '0f49bfb0-6414-43f1-bdc6-8c97a7290e6d')
	
*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF p_is_in_use = -1 THEN
	
		SELECT a.pymt_mode_id, a.modified_on, a.modified_by, a.pymt_mode_desc, a.pymt_type_id, b.store_name, a.is_in_use
		FROM tb_pymt_mode a
		INNER JOIN tb_store b ON b.store_id = ANY(regexp_split_to_array(a.for_store, ';;')::uuid[])
		WHERE b.store_id = p_store_id
		ORDER BY 
			a.pymt_mode_desc;
	
	ELSE
	
		PERFORM a.pymt_mode_id, null AS modified_on, null AS modified_by, a.pymt_mode_desc, null AS pymt_type_id, null AS store_name, null AS is_in_use
		FROM tb_pymt_mode a
		WHERE EXISTS (
			SELECT 1
    		FROM regexp_split_to_table(a.for_store, ';;') AS store
			WHERE store::uuid = p_store_id
		) AND a.is_in_use = p_is_in_use
		ORDER BY 
			a.pymt_mode_desc;
	
	END IF;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;