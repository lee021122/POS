CREATE OR REPLACE PROCEDURE pr_order_trans_refresh (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_order_trans_id uuid,
	IN p_doc_no character varying(50),
	IN p_tr_status character varying(50),
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_amt numeric(15, 4);
	v_total_tax numeric(15, 4);
	v_rounding_adj_amt numeric(15, 4);
	v_discount_amt numeric(15, 4);
	v_discount_pct numeric(15, 2);
	v_total_disc numeric(15, 4);
	v_outstanding_amt numeric(15, 4);
	module_code text;
	audit_log text;
	v_now CONSTANT timestamp = current_timestamp;
BEGIN
/*
	
	DO $$
	DECLARE
		v_msg text;  -- Variable to capture the OUT parameter 'p_msg'
	BEGIN
		CALL pr_order_trans_refresh(
			p_current_uid => 'tester',
			p_msg => null,
			p_order_trans_id => '0c000e65-38ab-44c6-b475-e53fcb80308b',
			p_doc_no => 'OR-2024101600001',
			p_tr_status => 'C',  -- Example transaction status
			p_is_debug => 0  -- Debug mode off (optional)
		);

		-- Output the message after the procedure call
		RAISE NOTICE 'Message: %', v_msg;
	END $$;

	
*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_order_trans_refresh - start';
	END IF;
	
	module_code := 'Order';

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	-- Calc Total Tax
	SELECT ROUND(SUM(total_tax), 2) 
	INTO v_total_tax 
	FROM tb_order_trans_item_line 
	WHERE 
		order_trans_id = p_order_trans_id 
		AND doc_no = p_doc_no;
		
	-- Calc Total Discount Amount
	SELECT ROUND(SUM(total_disc_amt), 2)
	INTO v_total_disc
	FROM tb_order_trans_item_line 
	WHERE 
		order_trans_id = p_order_trans_id 
		AND doc_no = p_doc_no;
		
	-- Calc Total Amount
	SELECT ROUND(SUM(amt), 2)
	INTO v_amt
	FROM tb_order_trans_item_line 
	WHERE 
		order_trans_id = p_order_trans_id 
		AND doc_no = p_doc_no
		AND is_pymt = 0;
		
	-- Calc Total Payment
	IF NOT EXISTS (
		SELECT *
		FROM tb_order_trans_item_line
		WHERE 
			order_trans_id = p_order_trans_id 
			AND doc_no = p_doc_no
			AND is_pymt = 1
			AND seq between 1000 and 2000
	) THEN 
		
		SELECT ROUND(SUM(amt), 2)
		INTO v_outstanding_amt
		FROM tb_order_trans_item_line 
		WHERE 
			order_trans_id = p_order_trans_id 
			AND doc_no = p_doc_no
			AND is_pymt = 0;
	
	ELSE 
	
		v_outstanding_amt := 0;
	
	END IF;
	
	-- Update Amount
	UPDATE tb_order_trans
	SET
		amt = v_amt,
		total_tax = v_total_tax,
		rounding_adj_amt = v_rounding_adj_amt,
		total_disc = v_total_disc,
		outstanding_amt = v_outstanding_amt
	WHERE 
		order_trans_id = p_order_trans_id 
		AND doc_no = p_doc_no;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_order_trans_refresh - end';
	END IF;

END
$BODY$;