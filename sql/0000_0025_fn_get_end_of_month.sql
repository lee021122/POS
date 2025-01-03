CREATE OR REPLACE FUNCTION fn_get_end_of_month()
RETURNS DATE
LANGUAGE 'plpgsql'
AS $$
BEGIN
/*
	select * from fn_get_end_of_month()
*/

	RETURN date_trunc('month', current_date) + INTERVAL '1 month' - INTERVAL '1 day';

END
$$;