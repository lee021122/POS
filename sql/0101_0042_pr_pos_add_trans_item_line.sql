CREATE OR REPLACE PROCEDURE pr_pos_add_trans_item_line (
	IN p_current_uid character varying(255),
	--IN p_sess_id uuid,
	OUT p_msg text,
	OUT p_order_trans_item_line_id uuid,
	IN p_tr_date date,
	IN p_tr_type character varying(50),
	IN p_tr_status character varying(50),
	IN p_order_trans_id uuid,
	IN p_doc_no character varying(255),
	IN p_product_id uuid,
	IN p_cost numeric(15, 4),
	IN p_sell_price numeric(15, 4),
	IN p_addon_amt numeric(15, 4),
	IN p_amt numeric(15, 4),
	IN p_qty integer,
	IN p_discount_id uuid,
	IN p_discount_amt numeric(15, 4),
	IN p_discount_pct numeric(15, 4),
	IN p_total_disc_amt numeric(15, 4),
	IN p_is_pymt integer,
	IN p_pymt_mode_id uuid,
	IN p_ref_no character varying(255),
	IN p_remarks character varying(255), 
	IN p_coupon_no character varying(255),
	IN p_coupon_id uuid,
	IN p_rid integer,
	IN p_axn character varying(255),
	IN p_url character varying(255),
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE 
	v_tax_code1 character varying(255);
	v_tax_pct1 numeric(15, 4);
	v_amt_include_tax1 integer;
	v_tax_amt1_calc numeric(15, 4);
	v_tax_code2 character varying(255);
	v_tax_pct2 numeric(15, 4);
	v_amt_include_tax2 integer;
	v_calc_tax2_after_tax1 integer;
	v_tax_amt2_calc numeric(15, 4);
	v_cost numeric(15, 4);
	v_seq integer;
	v_now CONSTANT timestamp = current_timestamp;
	v_today_dt CONSTANT date = current_date;
	v_setting_value text;
	v_msg2 text;
	module_code text;
	audit_log text;
BEGIN
/*

	DO $$
	DECLARE
		v_msg text;
		v_order_trans_item_line_id uuid;
	BEGIN
	
	select * from tb_product
	select * from tb_order_trans_table
	select * from tb_order_trans_item_line
	select * from tb_pymt_mode
	
		CALL pr_pos_add_trans_item_line(
			p_current_uid => 'tester',
			p_msg => null,
			p_order_trans_item_line_id => null,
			p_tr_date => null,
			p_tr_type => 'TS',
			p_tr_status => 'C', 
			p_order_trans_id => '9f1e591e-89ed-46ab-b07a-9e4602dab5c8',
			p_doc_no => 'TS2024101600002',
			p_product_id => null,
			p_cost => null,
			p_sell_price => null,
			p_addon_amt => null,
			p_amt => 15,
			p_qty => null,
			p_discount_id => null,
			p_discount_amt => null,
			p_discount_pct => null,
			p_total_disc_amt => null,
			p_is_pymt => null,
			p_pymt_mode_id => '59c5e753-9e2a-48d8-84c3-55ec53606d3c',
			p_ref_no => null,
			p_remarks => null,
			p_coupon_no => null,
			p_coupon_id => null,
			--p_store_id => '0f49bfb0-6414-43f1-bdc6-8c97a7290e6d',
			p_rid => null,
			p_axn => null,
			p_url => null,
			p_is_debug => 0
		);

		-- Output message and order_trans_item_line_id after calling the procedure
		RAISE NOTICE 'Message: %, Order Trans Item Line ID: %', v_msg, v_order_trans_item_line_id;
	END $$;

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_pos_add_trans_item_line - start';
	END IF;
	
	module_code := 'Order - Add Item Line';

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF p_tr_date IS NULL THEN
		p_tr_date := fn_get_current_trans_dt();
	END IF;
	
-- 	IF p_tr_date < v_today_dt THEN
-- 		p_msg := 'Please make sure night audit has been done, current transaction date: ' || p_tr_date::TEXT;
-- 		RETURN;
-- 	END IF;
	
	IF p_product_id IS NOT NULL THEN 
		IF NOT EXISTS (
			SELECT product_id
			FROM tb_product
			WHERE product_id = p_product_id
		) THEN
			p_msg := 'Invalid Product!!';
			RETURN;
		END IF;
	END IF;
	
	-- Get setting value
	v_setting_value := (SELECT sys_setting_value FROM tb_sys_setting WHERE sys_setting_title = 'OPERATION_MODE');
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
		
	IF fn_to_guid(p_product_id) <> fn_empty_guid() THEN 
		
		p_is_pymt := 0;
		p_pymt_mode_id = fn_empty_guid();
		v_seq := (
			SELECT COALESCE(MAX(seq), 0)
			FROM tb_order_trans_item_line
			WHERE order_trans_id = p_order_trans_id
		) + 1;

		-- Get Product Tax Setting
		SELECT tax_code1, amt_include_tax1, tax_code2, amt_include_tax2, calc_tax2_after_tax1, cost
		INTO v_tax_code1, v_amt_include_tax1, v_tax_code2, v_amt_include_tax2, v_calc_tax2_after_tax1, p_cost
		FROM tb_product
		WHERE product_id = p_product_id;

		-- Do Tax Calculation
		SELECT final_price, unit_price, tax_pct1, tax_amt1_calc, tax_pct2, tax_amt2_calc
		INTO p_amt, p_sell_price, v_tax_pct1, v_tax_amt1_calc, v_tax_pct2, v_tax_amt2_calc
		FROM fn_tax_calculation (
			v_tax_code1,
			v_tax_code2,
			v_amt_include_tax1,
			v_amt_include_tax2,
			v_calc_tax2_after_tax1,
			p_qty,
			p_cost
		);

		IF (COALESCE(p_discount_pct, 0) > 0 OR COALESCE(p_discount_amt, 0) > 0) THEN

			p_total_disc_amt := p_qty * p_sell_price * COALESCE(p_discount_pct, 0) / 100 + p_qty * COALESCE(p_discount_amt);
			p_cost := p_cost * (1 - COALESCE(p_discount_pct, 0) / 100) - COALESCE(p_discount_amt, 0);

			SELECT final_price, unit_price, tax_pct1, tax_amt1_calc, tax_pct2, tax_amt2_calc
			INTO p_amt, p_sell_price, v_tax_pct1, v_tax_amt1_calc, v_tax_pct2, v_tax_amt2_calc
			FROM fn_tax_calculation (
				v_tax_code1,
				v_tax_code2,
				v_amt_include_tax1,
				v_amt_include_tax2,
				v_calc_tax2_after_tax1,
				p_qty,
				p_cost
			);

		END IF;
			
	ELSIF fn_to_guid(p_pymt_mode_id) <> fn_empty_guid() THEN 
		
		IF NOT EXISTS (
			SELECT * 
			FROM tb_pymt_mode
			WHERE pymt_mode_id = p_pymt_mode_id
		) THEN
			p_msg := 'Invalid Payment Mode!!';
			RETURN;
		END IF;
			
		p_product_id := fn_empty_guid();
		p_cost := 0;
		p_qty := 0;
		p_sell_price := 0;
		p_is_pymt := 1;
		
		IF p_remarks = 'Amount Change Due' THEN
			v_seq := 2000;
		ELSE 
			v_seq := (
				SELECT COALESCE(MAX(seq), 999)
				FROM tb_order_trans_item_line
				WHERE order_trans_id = p_order_trans_id
				AND is_pymt = 1
			) + 1;
		END IF;
		
			
		p_discount_id := fn_empty_guid();
		p_discount_pct := NULL;
		p_discount_amt := NULL;
		p_total_disc_amt := NULL;
		
		IF v_setting_value = 'Pay-later' THEN
			
			UPDATE tb_order_trans_table
			SET 
				order_trans_id = null,
				doc_no = null,
				is_occ = 0
			WHERE table_desc = p_table_no;
			
		END IF;
		
	END IF;
		
	p_order_trans_item_line_id := gen_random_uuid();
		
	-- Insert Data
	INSERT INTO tb_order_trans_item_line (
		order_trans_item_line_id, created_on, created_by, modified_on, modified_by, tr_date, tr_type, tr_status, doc_no, product_id, qty, cost, sell_price,
    	seq, order_trans_id, discount_id, discount_amt, discount_pct, total_disc_amt, is_pymt, pymt_mode_id, ref_no, remarks, amt, 
		price_override_on, price_override_by, coupon_no, coupon_id, tax_code1, tax_pct1, tax_amt1_calc, tax_code2, tax_pct2, tax_amt2_calc
	) values (
		p_order_trans_item_line_id, v_now, p_current_uid, v_now, p_current_uid, p_tr_date, p_tr_type, p_tr_status, p_doc_no, p_product_id, p_qty, p_cost, p_sell_price,
		v_seq, p_order_trans_id, p_discount_id, p_discount_amt, p_discount_pct, p_total_disc_amt, p_is_pymt, p_pymt_mode_id, p_ref_no, p_remarks, p_amt, 
		null, null, p_coupon_no, p_coupon_id, v_tax_code1, v_tax_pct1, v_tax_amt1_calc, v_tax_code2, v_tax_pct2, v_tax_amt2_calc
	);
		
	IF v_setting_value = 'Pay-first' THEN
		
		IF EXISTS (
			SELECT *
			FROM tb_order_trans_item_line
			WHERE 
				order_trans_id = p_order_trans_id
				AND is_pymt = 1
		) THEN
			
		-- Send order to kitchen printer
		
		-- Update trans table is-occ to 0
		UPDATE tb_order_trans_table
		SET 
			order_trans_id = null,
			doc_no = null,
			is_occ = 0
		WHERE table_desc = p_table_no;
		
		END IF;
	END IF;

	
	p_msg := 'ok';
	
	-- Update the total amount
	CALL pr_order_trans_refresh (
		p_current_uid => p_current_uid,
		p_msg => v_msg2,
		p_order_trans_id => p_order_trans_id,
		p_doc_no => p_doc_no,
		p_tr_status => p_tr_status,  
		p_is_debug => 0  
	);
	
	IF v_msg2 <> 'ok' THEN 
		p_msg := 'Error happen in process!!';
		RETURN;
	END IF;
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_pos_add_trans_item_line'
		, p_uid => p_current_uid
		, p_id1 => p_order_trans_item_line_id
		, p_id2 => null
		, p_id3 => null
     	, p_app_id => null
		, p_module_code => module_code
	); 

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_pos_add_trans_item_line - end';
	END IF;

END
$BODY$;