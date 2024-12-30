CREATE OR REPLACE FUNCTION fn_get_curr_code (
	p_current_uid character varying(255),
	p_store_id uuid
) RETURNS TEXT 
LANGUAGE 'plpgsql'
AS $$
DECLARE
	v_curr_code text;
BEGIN
/*

*/

	SELECT curr_code
	INTO v_curr_code
	FROM tb_store
	WHERE store_id = p_store_id;
	
	RETURN v_curr_code;

END
$$;