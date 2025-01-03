CREATE OR REPLACE FUNCTION fn_get_begin_of_last_month()
RETURNS DATE
LANGUAGE 'plpgsql'
AS $$
BEGIN
/*
	select * from fn_get_begin_of_last_month()
*/

	RETURN date_trunc('month', current_date)::DATE - INTERVAL '1 month';

END
$$;