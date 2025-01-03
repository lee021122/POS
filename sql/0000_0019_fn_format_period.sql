CREATE OR REPLACE FUNCTION fn_format_period (
	p_start_dt date,
	p_end_dt date
) RETURNS TEXT 
LANGUAGE 'plpgsql'
AS $$
DECLARE
	prd text;
BEGIN

	IF p_start_dt IS NOT NULL AND p_end_dt IS NOT NULL THEN
	
		IF p_start_dt = p_end_dt THEN
			prd := p_start_dt;
			
		ELSIF DATE_PART('day', p_start_dt) <> DATE_PART('day', p_end_dt)
			AND DATE_PART('month', p_start_dt) = DATE_PART('month', p_end_dt)
			AND DATE_PART('year', p_start_dt) = DATE_PART('year', p_end_dt)
		THEN
			prd := DATE_PART('day', p_start_dt)::text || ' - ' || fn_fmt_date(p_end_dt);
		
		ELSIF DATE_PART('day', p_start_dt) <> DATE_PART('day', p_end_dt)
			AND DATE_PART('month', p_start_dt) <> DATE_PART('month', p_end_dt)
			AND DATE_PART('year', p_start_dt) = DATE_PART('year', p_end_dt)
		THEN
			prd := DATE_PART('day', p_start_dt)::text 
					|| '/' 
					|| DATE_PART('month', p_start_dt)::text
					|| ' - '
					|| DATE_PART('day', p_end_dt)::text 
					|| '/' 
					|| DATE_PART('month', p_end_dt)::text
					|| '/'
					|| DATE_PART('year', p_end_dt)::text;
			
		ELSE
		
			prd := fn_fmt_date(p_start_dt) || ' - ' || fn_fmt_date(p_end_dt);
		
		END IF;
		
	ELSIF p_start_dt IS NOT NULL THEN
		prd := fn_fmt_date(p_start_dt);
		
	ELSIF p_end_dt IS NOT NULL THEN
		prd := fn_fmt_date(p_end_dt);
		
	ELSE
		prd := '';
	END IF;
	
	RETURN prd;

END
$$;