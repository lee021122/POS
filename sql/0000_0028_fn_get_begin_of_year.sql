CREATE OR REPLACE FUNCTION fn_get_begin_of_year()
RETURNS DATE
LANGUAGE 'plpgsql'
AS $$
BEGIN
/*
	select * from fn_get_begin_of_year()
*/

	RETURN date_trunc('year', current_date)::DATE;

END
$$;