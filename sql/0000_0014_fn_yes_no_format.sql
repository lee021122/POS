CREATE OR REPLACE FUNCTION fn_yes_no_format (
	p_yes_no integer
) RETURNS TEXT 
LANGUAGE 'plpgsql'
AS $$
DECLARE

BEGIN
/*
	SELECT * FROM fn_yes_no_format(1);
	SELECT * FROM fn_yes_no_format(12345);
	SELECT * FROM fn_yes_no_format(0);
*/

	RETURN 
		CASE WHEN p_yes_no = 1 THEN 'Yes'
		ELSE 'No'
		END;
		

END
$$;