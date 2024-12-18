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
	amt_length integer = 9;
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
BEGIN
/*
	select * from fn_pos_trans_receipt ('tester', 'c729f3df-7161-418a-a55e-c81c13026b32', null, null, null)
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
	SELECT doc_no, pax, CASE WHEN tr_type = 'TS' THEN table_no ELSE '-' END AS table_no, CASE WHEN tr_type = 'RS' THEN room_no ELSE '-' END AS room_no, created_by, created_on
	INTO v_doc_no, v_pax, v_table_no, v_room_no, v_cashier, v_date
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
	(400, 1, ' Qty ' || RPAD('Item', item_length, ' ') || RPAD('Amt', amt_length, ' ')),
	(400, 2, seperator);
	
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		401,
		a.seq,
		LPAD(a.qty::text, qty_length, ' ') || ' ' || RPAD(b.product_desc, item_length, ' ') || RPAD(ROUND(a.amt, 2)::text, amt_length, ' ')
	FROM item_line a
	LEFT JOIN tb_product b ON b.product_id = a.product_id;
	
	-- Seperator
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(402, 0, seperator);
	
	-- Summ
-- 	SELECT 
-- 	INSERT INTO tb (seq, seq2, line_data) VALUES 
-- 	(501, 1, )

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