CREATE OR REPLACE FUNCTION fn_get_past_7days()
RETURNS DATE
LANGUAGE 'plpgsql'
AS $$
BEGIN
/*
	select * from fn_get_past_7days()
*/

	RETURN current_date - INTERVAL '6 days';

END
$$;