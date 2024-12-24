CREATE OR REPLACE FUNCTION fn_pos_trans_receipt (
	p_current_uid character varying(255),
	p_order_trans_id uuid,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	line_data text
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	max_length integer = 40;
	seperator text;
	qty_length integer = 4;
	amt_length integer = 10;
	item_length integer;
	v_is_show_store_name integer;
	v_is_show_store_details integer;
	v_is_show_customer_details integer;
	v_is_show_customer_point integer;
	v_store_name text;
	v_business_reg_num text;
	v_addr_line_1 text;
	v_addr_line_2 text;
	v_city text; 
	v_state_name text;
	v_post_code text;
	v_country_name text;
	v_phone_number text;
	v_email text;
	v_website text;
	v_doc_no text;
	v_pax integer;
	v_table_no text;
	v_room_no text;
	v_cashier text;
	v_date timestamp;
	v_sub_total numeric(15, 4);
	v_rounding numeric(15, 4);
	v_bill_disc_pct numeric(15, 2);
	v_bill_disc_amt numeric(15, 4);
	v_total_bill_disc numeric(15, 4);
	v_total_amt numeric(15, 4);
	v_ds text;
	v_due numeric(15, 4);
BEGIN
/*
	select * from fn_pos_trans_receipt ('tester', '7c19610f-510d-4ac8-9189-e9e4c0dbd121', null, null, null)
*/	

	CREATE TEMPORARY TABLE tb (
		seq integer,
		seq2 integer,
		line_data text
	);
	
	seperator := REPEAT('-', max_length);
	item_length := max_length - 1 - qty_length - amt_length;

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	-- Check Receipt Template 
	SELECT is_show_store_name, is_show_store_details, is_show_customer_details, is_show_customer_point
	INTO v_is_show_store_name, v_is_show_store_details, v_is_show_customer_details, v_is_show_customer_point
	FROM tb_receipt_temp
	WHERE is_in_use = 1;
	
	IF v_is_show_store_name = 1 THEN
		SELECT store_name
		INTO v_store_name
		FROM tb_store;
	END IF;
	
	IF v_is_show_store_details = 1 THEN 
		SELECT a.business_registration_num, a.addr_line_1, a.addr_line_2, a.city, b.state_name, a.post_code, c.country_name, a.phone_number, a.email, a.website
		INTO v_business_reg_num, v_addr_line_1, v_addr_line_2, v_city, v_state_name, v_post_code, v_country_name, v_phone_number, v_email, v_website
		FROM tb_store a
		LEFT JOIN tb_state b ON b.state_id = a.state
		LEFT JOIN tb_country c ON c.country_id = a.country
		WHERE b.is_in_use = 1 AND c.is_in_use = 1;
	END IF;

	-- -------------------------------------
	-- process
	-- -------------------------------------
	CREATE TEMPORARY TABLE order_trans AS
	SELECT *
	FROM tb_order_trans
	WHERE order_trans_id = p_order_trans_id;
	
	CREATE TEMPORARY TABLE item_line AS
	SELECT *
	FROM tb_order_trans_item_line
	WHERE order_trans_id = p_order_trans_id;
	
	CREATE TEMPORARY TABLE modifier AS 
	SELECT *
	FROM tb_order_trans_modifier
	WHERE order_trans_id = p_order_trans_id;
	
	-- Prepare the data
	-- Header (101 - Store Details) 
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(101, 1, v_store_name),
	(101, 2, 'Registration No: ' || v_business_reg_num),
	(101, 3, v_addr_line_1 || ', '),
	(101, 4, v_addr_line_2 || ', '), 
	(101, 5, v_post_code || ', ' || v_state_name || ', '),
	(101, 6, v_country_name),
	(101, 7, v_phone_number),
	(101, 8, v_email),
	(101, 9, v_website);
	
	-- Seperator
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(102, 0, seperator);
	
	-- Customer Info (201)
	
	-- Receipt Info (301)
	SELECT 
		doc_no, 
		pax, 
		CASE WHEN tr_type = 'TS' THEN table_no ELSE '-' END AS table_no, 
		CASE WHEN tr_type = 'RS' THEN room_no ELSE '-' END AS room_no, 
		created_by, 
		created_on, 
		COALESCE(rounding_adj_amt, 0),
		discount_pct,
		discount_amt,
		total_disc,
		amt
	INTO 
		v_doc_no, 
		v_pax, 
		v_table_no, 
		v_room_no, 
		v_cashier, 
		v_date, 
		v_rounding,
		v_bill_disc_pct,
		v_bill_disc_amt,
		v_total_bill_disc,
		v_total_amt
	FROM order_trans;
	
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(301, 1, 'Invoice No: ' || v_doc_no),
	(301, 2, 'Pax: ' || v_pax),
	(301, 3, 'Table No: ' || v_table_no),
	(301, 4, 'Room No: ' || v_room_no),
	(301, 5, 'Cashier: ' || v_cashier),
	(301, 6, 'Date: ' || v_date);
	
	-- Seperator
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(302, 0, seperator);
	
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(400, 1, ' Qty ' || RPAD('Item', item_length, ' ') || LPAD('Amt', amt_length, ' ')),
	(400, 2, seperator);
	
	-- Item Line (401)
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		401,
		a.seq * 100,
		LPAD(a.qty::text, qty_length, ' ') || ' ' || RPAD(b.product_desc, item_length, ' ') || LPAD(ROUND(a.amt, 2)::text, amt_length, ' ')
	FROM item_line a
	LEFT JOIN tb_product b ON b.product_id = a.product_id
	WHERE a.is_pymt = 0;
	
	-- Modifier (402)
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		401,
		(a.seq * 100) + 1,
		LPAD(' ', qty_length, ' ') || ' ' || RPAD('--> ' || c.modifier_option_name, item_length, ' ')
	FROM item_line a
	INNER JOIN tb_order_trans_modifier b ON b.order_trans_item_line_id = a.order_trans_item_line_id
	INNER JOIN tb_modifier_option c ON c.modifier_option_id = b.modifier_option_id;
	
	-- User Remarks
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		401,
		(a.seq * 100) + 1,
		LPAD(' ', qty_length, ' ') || ' ' || RPAD('* ' || a.remarks, item_length, ' ')
	FROM item_line a
	WHERE 
		a.is_pymt = 0
		AND a.remarks IS NOT NULL;
	
	-- Seperator
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(402, 0, seperator);
	
	-- Total Summary
	-- Part 1: Sub-total
	SELECT	
		SUM(
			CASE WHEN a.amt > b.sell_price THEN (b.sell_price + a.amt - b.sell_price) * a.qty		-- With Modifier
			ELSE  b.sell_price * a.qty																-- Without Modifier
			END
		)
	INTO v_sub_total
	FROM item_line a
	INNER JOIN tb_product b ON b.product_id = a.product_id;
	
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(501, 1, LPAD(' ', qty_length, ' ') || ' ' || RPAD('Sub-Total: ', item_length, ' ') || LPAD(ROUND(v_sub_total, 2)::text, amt_length, ' ')),
	-- Part 2: Rounding
	(501, 2, LPAD(' ', qty_length, ' ') || ' ' || RPAD('Rounding: ', item_length, ' ') || LPAD(ROUND(v_rounding, 2)::text, amt_length, ' '));
	
	-- Part 3: Discount
	IF v_total_bill_disc > 0 THEN
		v_ds := 'Bill Discount: ';
		
		IF v_bill_disc_pct > 0 OR v_bill_disc_amt > 0 THEN
			v_ds := v_ds || '(';
			
			IF v_bill_disc_pct > 0 THEN
				v_ds := v_ds || ROUND(v_bill_disc_pct, 2) || '%';
			ELSE
				v_ds := v_ds || ROUND(v_bill_disc_amt, 2);
			END IF;
			
			v_ds := v_ds || ')';
		END IF;
		
		INSERT INTO tb (seq, seq2, line_data) VALUES 
		(501, 3, LPAD(' ', qty_length, ' ') || ' ' || RPAD(v_ds, item_length, ' ') || LPAD(ROUND(-1 * v_total_bill_disc, 2)::text, amt_length, ' '));
	END IF;
	
	-- Seperator
	INSERT INTO tb (seq, seq2, line_data) VALUES
	(501, 4, LPAD(' ', qty_length, ' ') || ' All Price Include SC & SST'),
	(501, 5, seperator),
	-- Part 4: Total
	(501, 6, LPAD(' ', qty_length, ' ') || ' ' || RPAD('Total: ', item_length, ' ') || LPAD(ROUND(v_total_amt, 2)::text, amt_length, ' '));
	
	-- Part 5: Payment
	INSERT INTO tb (seq, seq2, line_data)
	SELECT
		501,
		7,
		LPAD(' ', qty_length, ' ') || ' ' || RPAD(b.pymt_mode_desc, item_length, ' ') || LPAD(ROUND(a.amt, 2)::text, amt_length, ' ')
	FROM item_line a
	INNER JOIN tb_pymt_mode b ON b.pymt_mode_id = a.pymt_mode_id
	WHERE a.seq <> 2000;
	
	-- Part 6: Change Due
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		501,
		8,
		LPAD(' ', qty_length, ' ') || ' ' || RPAD('Change', item_length, ' ') || LPAD(ROUND(COALESCE(amt, 0), 2)::text, amt_length, ' ')
	FROM item_line
	WHERE seq = 2000;
	
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(501, 9, seperator),
	(501, 10, LPAD(' ', qty_length, ' ') || ' ' || 'Tax Summ: ');
	
	-- Part 7: Tax	
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		501,
		11, 
		LPAD(' ', qty_length, ' ') || ' ' || RPAD('Service Charge:', item_length, ' ') || LPAD(ROUND(SUM(a.tax_amt1_calc), 2)::text, amt_length, ' ')
	FROM item_line a
	WHERE a.is_pymt = 0;
	
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		501,
		11, 
		LPAD(' ', qty_length, ' ') || ' ' || RPAD('Sales & Service Tax:', item_length, ' ') || LPAD(ROUND(SUM(a.tax_amt2_calc), 2)::text, amt_length, ' ')
	FROM item_line a
	WHERE a.is_pymt = 0;
	
	RETURN QUERY (
		SELECT a.line_data 
		FROM tb a 
		ORDER BY a.seq, a.seq2
	);

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	
	DROP TABLE tb;
	DROP TABLE order_trans;
	DROP TABLE item_line;
	DROP TABLE modifier;

END
$$;