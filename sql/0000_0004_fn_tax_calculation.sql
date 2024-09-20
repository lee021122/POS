CREATE OR REPLACE FUNCTION fn_tax_calculation (
	p_tax_code1 character varying(255),
	p_tax_code2 character varying(255),
	p_tax_include_tax1 integer,
	p_tax_include_tax2 integer,
	p_calc_tax2_after_tax1 integer,
	p_qty integer,
	p_amt numeric(15, 2)	
) RETURNS TABLE (
	final_price numeric(15, 4),
	unit_price numeric(15, 4),
	qty integer,
	tax_code1 character varying(255),
	tax_pct1 numeric(15, 4),
	tax_amt_calc1 numeric(15, 4),
	tax_code2 character varying(255),
	tax_pct2 numeric(15, 4),
	tax_amt_calc2 numeric(15, 4)
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	t1 character varying(50);
	t2 character varying(50);
	i1 integer;
	i2 integer;
	after1 integer;
	p1 numeric(15, 4);
	p2 numeric(15, 4);
	f_price numeric(15, 4);
	temp_amt numeric(15, 4);
	temp_amt2 numeric(15, 4);
	total_tax_pct numeric(15, 4);
	u_price numeric(15, 4);
	t_calc1 numeric(15, 4);
	t_calc2 numeric(15, 4);

BEGIN 
/* 0000_0004_fn_tax_calculation

	SELECT * 
	FROM fn_tax_calculation(
		p_tax_code1 => 'SC',
		p_tax_code2 => 'SST-6%',
		p_tax_include_tax1 => 1,
		p_tax_include_tax2 => 1,
		p_calc_tax2_after_tax1 => 0,
		p_qty => 2,
		p_amt => 20	
	)

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF p_qty <= 0 THEN p_qty := 1; END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	-- Get tax pct
	SELECT tax_pct / 100
	INTO p1
	FROM tb_tax
	WHERE 
		tax_code = p_tax_code1
		AND is_in_use = 1;
	
	SELECT tax_pct / 100
	INTO p2
	FROM tb_tax
	WHERE 
		tax_code = p_tax_code2
		AND is_in_use = 1;
	
	t1 := p_tax_code1;
	t2 := p_tax_code2;
	i1 := COALESCE(p_tax_include_tax1, 0);
	i2 := COALESCE(p_tax_include_tax2, 0);
	after1 := COALESCE(p_calc_tax2_after_tax1, 0);
	
	IF t1 IS NULL AND t2 IS NULL THEN 
	
		f_price := p_amt * p_qty;
	
	-- SST
	ELSIF t1 IS NOT NULL AND t2 IS NOT NULL AND i1 = 1 AND i2 = 1 AND after1 = 0 THEN
		
		temp_amt := p_amt * p_qty;
		f_price := temp_amt;
		total_tax_pct := 1 + p1 + p2;
		
		temp_amt2 := f_price / total_tax_pct;
		u_price := temp_amt2 / p_qty;
		
		t_calc1 := temp_amt2 * p1;
		t_calc2 := temp_amt2 * p2;
		
	ELSE 
	
		IF t1 IS NOT NULL THEN
		
			temp_amt := p_amt * p_qty;
			
			-- Not include tax 1
			IF COALESCE(i1, 0) = 0 THEN
			
				t_calc1 := temp_amt * p1;
				f_price := temp_amt + t_calc1;
			
			-- Include tax 1
			ELSE 
				
				temp_amt2 := temp_amt / (1 + p1);
				t_calc1 := temp_amt2 * p1;
				
				f_price := temp_amt2 + t_calc1;
				u_price := f_price / p_qty;
			
			END IF;
		
		END IF;
		
-- 		IF t2 IS NOT NULL THEN
		
-- 			temp_amt := p_amt * p_qty;
			
-- 			IF COALESCE(after1, 0) = 1 THEN
			
-- 				t_calc1 = 
			
-- 			END IF;
		
-- 			IF COALESCE(i2, 0) = 0 THEN
			
			
		
-- 		END IF;
	
	END IF;
	
	RETURN QUERY(
		-- Return the final result
		SELECT
			f_price AS final_price,
			u_price AS unit_price,
			p_qty AS qty,
			t1 AS tax_code1,
			p1 AS tax_pct1,
			t_calc1 AS tax_amt_calc1,
			t2 AS tax_code2,
			p2 AS tax_pct2,
			t_calc2 AS tax_amt_calc2
	);
	

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;