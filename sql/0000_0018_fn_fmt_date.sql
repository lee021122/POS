CREATE OR REPLACE FUNCTION fn_fmt_date (
	p_dt date
) RETURNS TEXT 
LANGUAGE 'plpgsql'
AS $$
DECLARE
	d text;
BEGIN
/*
	select * from fn_fmt_date('20241122')
*/

	RETURN 
		TO_CHAR(p_dt, 'dd/mm/yyyy');
	
END
$$;