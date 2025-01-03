CREATE OR REPLACE FUNCTION fn_rpt_sst (
	p_current_uid character varying(255),
	p_start_dt date,
	p_end_dt date,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	dt text,
	order_no character varying(255),
	product_desc character varying(255),
	tac_code character varying(255),
	tax_desc character varying(255),
	tax_amt numeric(15, 2)
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	module_code text;
	audit_log text;
BEGIN
/*

*/

	module_code := 'Report - Service Charge Report';

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF p_start_dt IS NULL THEN
		p_start_dt := fn_get_current_date();
	END IF;
	
	IF p_end_dt IS NULL THEN
		p_end_dt := fn_get_next_7days();
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	RETURN QUERY (
		SELECT 
			a.tr_date::TEXT AS dt,
			a.doc_no AS order_no,
			b.product_desc,
			c.tax_code,
			c.tax_desc,
			ROUND(a.tax_amt2_calc, 2) AS tax_amt
		FROM tb_order_trans_item_line a 
		LEFT JOIN tb_product b ON b.product_id = a.product_id
		LEFT JOIN tb_tax c ON c.tax_code = a.tax_code2
		WHERE 
			a.tr_date BETWEEN p_start_dt AND p_end_dt
			AND a.tr_status = 'C'
			AND a.is_pymt = 0
		ORDER BY 
			a.tr_date,
			a.doc_no,
			c.product_desc
	);
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$$;