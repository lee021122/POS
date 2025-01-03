CREATE OR REPLACE FUNCTION fn_get_yesterday_date()
RETURNS DATE
LANGUAGE 'plpgsql'
AS $$
BEGIN
/*
	select * from fn_get_yesterday_date()
*/

	RETURN current_date - INTERVAL '1 day';

END
$$;