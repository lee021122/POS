CREATE OR REPLACE FUNCTION fn_get_current_date()
RETURNS DATE
LANGUAGE 'plpgsql'
AS $$
BEGIN
/*
	select * from fn_get_current_date()
*/
	RETURN current_date;
END
$$;