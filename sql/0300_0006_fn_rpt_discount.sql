CREATE OR REPLACE FUNCTION fn_rpt_discount (
	p_current_uid character varying(255),
	p_start_dt date,
	p_end_dt date,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	tr_date text,
	discount_by character varying,
	order_no character varying,
	reason text,
	product_desc character varying,
	qty integer,
	net_amt numeric(15, 2),
	disc_pct text,
	disc_amt numeric(15, 2),
	total_disc numeric(15, 2),
	amt_ad numeric(15, 2)
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
	SELECT * FROM fn_rpt_discount(
		'tester',
		'2024-11-20',
		'2024-12-01',
		null,
		null,
		null
	)

*/
	module_code := 'Report - Discount Report';

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
			a.tr_date::text,
			b.price_override_by AS discount_by,
			a.doc_no AS order_no,
			a.remarks AS reason,
			c.product_desc,
			b.qty,
			(c.sell_price * b.qty) AS net_amt,
			ROUND(b.discount_pct, 0)::text || '%' AS disc_pct,
			b.discount_amt AS disc_amt,
			b.total_disc_amt AS total_disc,
			b.amt AS amt_ad
		FROM tb_order_trans a
		LEFT JOIN tb_order_trans_item_line b ON b.order_trans_id = a.order_trans_id
		LEFT JOIN tb_product c ON c.product_id = b.product_id
		WHERE 
			a.tr_date BETWEEN p_start_dt AND p_end_dt
			AND a.tr_status = 'C'
			AND (b.discount_amt > 0 OR b.discount_pct > 0)
			AND b.is_pymt = 0
		ORDER BY 
			a.tr_date,
			a.doc_no, 
			b.qty,
			c.product_desc
	);
	
	audit_log := 'Viewing or Printing Discount Report.';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'fn_rpt_discount'
		, p_uid => p_current_uid
		, p_id1 => null
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	); 

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	
END
$$;