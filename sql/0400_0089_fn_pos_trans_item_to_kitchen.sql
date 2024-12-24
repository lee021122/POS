CREATE OR REPLACE FUNCTION fn_pos_trans_item_to_kitchen (
	p_current_uid character varying(255),
	p_order_trans_id uuid,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	line_data text,
	printer character varying(255)
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
	item_length integer;
	v_doc_no text;
	v_tr_type text;
	v_delivery text;
	count_result integer;
BEGIN
/*

	SELECT * FROM fn_pos_trans_item_to_kitchen (
		'tester',
		'5be8f329-54e4-48cd-8de7-d56751250a58',
		null,
		null,
		null
	);

*/
	CREATE TEMPORARY TABLE tb (
		seq integer,
		seq2 integer,
		line_data text,
		printer character varying(255)
	);
	
	seperator := REPEAT('-', max_length);
	item_length := max_length - 1 - qty_length;
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	CREATE TEMPORARY TABLE printer AS
	SELECT a.product_id, b.printer_name, b.is_default
	FROM tb_pos_printer_product a
	INNER JOIN tb_pos_printer b ON b.pos_printer_id = a.pos_printer_id
	WHERE 
		b.printer_type_id = 1
		AND b.is_in_use = 1;
	
	CREATE TEMPORARY TABLE item_line AS 
	SELECT  
		a.order_trans_id, a.order_trans_item_line_id, a.seq, a.product_id, a.qty, a.remarks, CASE WHEN a.qty <> c.qty THEN 1 ELSE 0 END AS change_qty, 0 AS is_void
	FROM tb_order_trans_item_line a
	INNER JOIN tb_product b ON b.product_id = a.product_id
	LEFT JOIN tb_item_trans_print_log c ON c.order_trans_id = a.order_trans_id and c.order_trans_item_line_id = a.order_trans_item_line_id
	WHERE 
		a.order_trans_id = p_order_trans_id 		-- 'c729f3df-7161-418a-a55e-c81c13026b32'
		AND (
			c.order_trans_item_line_id IS NULL			-- Not yet printed
			OR a.qty <> c.qty							-- Update Qty
		);
		
	-- Insert to tb prepare to print
	INSERT INTO tb_item_trans_print_log (order_trans_id, order_trans_item_line_id, printed_on, printed_by, product_id, qty) 
	SELECT a.order_trans_id, a.order_trans_item_line_id, now(), p_current_uid, a.product_id, a.qty
	FROM item_line a
	LEFT JOIN tb_item_trans_print_log b ON b.order_trans_id = a.order_trans_id and b.order_trans_item_line_id = a.order_trans_item_line_id
	WHERE b.order_trans_item_line_id IS NULL;
	
	-- Handle Update Qty
	UPDATE tb_item_trans_print_log 
	SET qty = a.qty
	FROM item_line a 
	INNER JOIN tb_item_trans_print_log b ON b.order_trans_id = a.order_trans_id and b.order_trans_item_line_id = a.order_trans_item_line_id
	WHERE a.qty <> b.qty;
	
	-- Handle void item, if already been printed
	INSERT INTO item_line (order_trans_item_line_id, seq, product_id, qty, remarks, change_qty, is_void)
	SELECT 
		a.order_trans_item_line_id, a.seq, a.product_id, a.qty, a.remarks, 0 AS change_qty, 1 AS is_void
	FROM tb_order_trans_item_line_void a
	INNER JOIN tb_product b ON b.product_id = a.product_id
	INNER JOIN tb_item_trans_print_log c ON c.order_trans_id = a.order_trans_id AND c.order_trans_item_line_id = a.order_trans_item_line_id
	WHERE
		a.order_trans_id = p_order_trans_id
		AND COALESCE(c.is_void, 0) = 0;
				
	-- mark the item as voided - to prevent sending this to the printer.
	UPDATE tb_item_trans_print_log
	SET is_void = 1
	FROM tb_item_trans_print_log a
	INNER JOIN item_line b ON b.order_trans_item_line_id = a.order_trans_item_line_id AND a.order_trans_id = p_order_trans_id
	WHERE
		b.is_void = 1;
		
	-- Modifier
	CREATE TEMPORARY TABLE modifier AS
	SELECT modifier_option_id, order_trans_item_line_id, order_trans_id
	FROM tb_order_trans_modifier
	WHERE order_trans_id = p_order_trans_id;
	
	-- Prepare the Prepare List
	-- Header
	SELECT 
		a.doc_no,
		CASE 
			WHEN a.tr_type = 'TS' THEN b.tr_type_desc || ' (' || a.table_no || ')'
			WHEN a.tr_type = 'PC' OR a.tr_type = 'TA' THEN b.tr_type_desc
			ELSE b.tr_type_desc || ' (' || a.room_no || ')'
		END AS tr_type, 
		a.delivery_time || CASE WHEN a.delivery_next_day IS NOT NULL THEN ' (Next Day)' ELSE '' END AS delivery
	INTO v_doc_no, v_tr_type, v_delivery
	FROM tb_order_trans a
	INNER JOIN tb_tr_type b ON b.tr_type_code = a.tr_type
	WHERE order_trans_id = p_order_trans_id;	
	
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(101, 1, 'Invoice No: ' || v_doc_no),
	(101, 2, 'Type: ' || v_tr_type);
	
	IF v_delivery IS NOT NULL THEN
		INSERT INTO tb (seq, seq2, line_data) VALUES 
		(101, 3, '<<==================>>'),
		(101, 4, 'Delivery Time' || v_delivery),
		(101, 5, '<<==================>>');
	END IF;
	
	INSERT INTO tb (seq, seq2, line_data) VALUES 
	(200, 1, seperator),
	(200, 2, ' Qty ' || RPAD('Item', item_length, ' ')),
	(200, 3, seperator);
	
	-- Item Line 
	INSERT INTO tb (seq, seq2, line_data, printer)
	SELECT
		201,
		a.seq * 100, 
		LPAD(a.qty::text, qty_length, ' ') || ' ' || RPAD(b.product_desc, item_length, ' '),
		c.printer_name
	FROM item_line a 
	INNER JOIN tb_product b ON b.product_id = a.product_id
	LEFT JOIN printer c ON c.product_id = b.product_id;
	
	-- Modifier 
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		201,
		(a.seq * 100) + 1,
		LPAD(' ', qty_length, ' ') || ' ' || RPAD('--> ' || c.modifier_option_name, item_length, ' ')
	FROM item_line a
	INNER JOIN modifier b ON b.order_trans_item_line_id = a.order_trans_item_line_id
	INNER JOIN tb_modifier_option c ON c.modifier_option_id = b.modifier_option_id;
	
	-- User Remarks
	INSERT INTO tb (seq, seq2, line_data)
	SELECT 
		201,
		(a.seq * 100) + 1,
		LPAD(' ', qty_length, ' ') || ' ' || RPAD('* ' || a.remarks, item_length, ' ')
	FROM item_line a
	WHERE a.remarks IS NOT NULL;
	
	RETURN QUERY (
		SELECT a.line_data, a.printer
		FROM tb a
		ORDER BY a.seq, a.seq2
	);
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	
	DROP TABLE printer;
	DROP TABLE item_line;
	DROP TABLE modifier;
	DROP TABLE tb;

END
$$;