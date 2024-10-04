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
    p1 numeric(15, 4) := 0;
    p2 numeric(15, 4) := 0;
    f_price numeric(15, 4);
    temp_amt numeric(15, 4);
    u_price numeric(15, 4);
    t_calc1 numeric(15, 4) := 0;
    t_calc2 numeric(15, 4) := 0;
    total_tax_pct numeric(15, 4);
BEGIN
/* 
	SELECT * 
	FROM fn_tax_calculation(
		p_tax_code1 => 'SC',
		p_tax_code2 => 'SST-6%',
		p_tax_include_tax1 => 1, 
		p_tax_include_tax2 => 1, 
		p_calc_tax2_after_tax1 => 0, 
		p_qty => 1,
		p_amt => 10	
	); 
*/
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	-- Ensure quantity is at least 1
    IF p_qty <= 0 THEN p_qty := 1; END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
    -- Retrieve tax percentages for both tax codes
    SELECT COALESCE((SELECT tax_pct / 100 FROM tb_tax WHERE tax_code = p_tax_code1 AND is_in_use = 1), 0)
    INTO p1;

    SELECT COALESCE((SELECT tax_pct / 100 FROM tb_tax WHERE tax_code = p_tax_code2 AND is_in_use = 1), 0)
    INTO p2;

    -- Base calculation: Amount * Quantity
    temp_amt := p_amt * p_qty;
    
    -- Calculate tax if included (1) or excluded (0)
    IF p_tax_include_tax1 = 1 THEN
        temp_amt := temp_amt / (1 + p1); -- Deduct tax1 from amount if included
    END IF;
    t_calc1 := temp_amt * p1; -- Calculate tax1 amount

    -- If tax2 depends on tax1
    IF p_calc_tax2_after_tax1 = 1 THEN
        temp_amt := temp_amt + t_calc1; -- Add tax1 before calculating tax2
    END IF;

    -- Calculate tax2 (included or excluded)
    IF p_tax_include_tax2 = 1 THEN
        temp_amt := temp_amt / (1 + p2); -- Deduct tax2 from amount if included
    END IF;
    t_calc2 := temp_amt * p2; -- Calculate tax2 amount

    -- Final price calculation (sum of base + taxes)
    f_price := temp_amt + t_calc1 + t_calc2;
    u_price := temp_amt / p_qty;

    -- Return the calculated values
    RETURN QUERY (
		 SELECT
			f_price AS final_price,
			u_price AS unit_price,
			p_qty AS qty,
			p_tax_code1 AS tax_code1,
			p1 AS tax_pct1,
			t_calc1 AS tax_amt_calc1,
			p_tax_code2 AS tax_code2,
			p2 AS tax_pct2,
			t_calc2 AS tax_amt_calc2
	);
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
   
END;
$BODY$;
