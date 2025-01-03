CREATE OR REPLACE FUNCTION fn_get_begin_of_month()
RETURNS DATE
LANGUAGE 'plpgsql'
AS $$
BEGIN
/*
	select * from fn_get_begin_of_month()
*/

	RETURN date_trunc('month', current_date)::DATE;

END
$$;