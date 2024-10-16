CREATE OR REPLACE PROCEDURE pr_order_trans_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_order_trans_id uuid,
	IN p_doc_no character varying(50),
	IN p_tr_date date,
	IN p_tr_type character varying(50),
	IN p_tr_status character varying(50),
	IN p_guest_id uuid,
	IN p_pax integer,
	IN p_table_no character varying(50),
	IN p_room_no character varying(50),
	IN p_delivery_time timestamp,
	IN p_delivery_next_day timestamp,
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_now CONSTANT timestamp = current_timestamp;
	audit_log text;
	module_code text;
	v_today_dt CONSTANT date = current_date;
	v_tr_type_old character varying(50);
	v_tr_status_old character varying(50);
	v_guest_id_old uuid;
	v_pax_old integer;
	v_table_no_old character varying(50);
	v_room_no_old character varying(50);
	v_delivery_time_old timestamp;
	v_delivery_next_day_old timestamp;
BEGIN
/* 
	-- Save the Order Trans (Step 3)
	
	DO $$
	DECLARE
		v_msg text;  -- Variable to store the OUT parameter 'p_msg'
	BEGIN
		CALL pr_order_trans_save(
			p_current_uid => 'tester',
			p_msg => null,
			p_order_trans_id => '0c000e65-38ab-44c6-b475-e53fcb80308b',
			p_doc_no => 'OR-2024101600001',
			p_tr_date => null,
			p_tr_type => 'TS',  
			p_tr_status => 'C',  
			p_guest_id => null,
			p_pax => 2,  -- Number of guests/pax
			p_table_no => 'T12',  -- Example table number
			p_room_no => null,  
			p_delivery_time => null,  -- Example delivery time
			p_delivery_next_day => NULL,  -- If applicable
			p_is_debug => 0  -- Debug mode off
		);

		-- Output the message after the procedure call
		RAISE NOTICE 'Message: %', v_msg;
	END $$;

*/
	
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_order_trans_save - start';
	END IF;
	
	module_code := 'Order';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF LENGTH(COALESCE(p_order_trans_id::TEXT, '')) = 0 THEN
		p_msg := 'Order Trans ID cannot be blank!!';
		RETURN;
	END IF;
	
	IF LENGTH(COALESCE(p_doc_no, '')) = 0 THEN
		p_msg := 'Order No cannot be blank!!';
		RETURN;
	END IF;
	
	IF p_tr_date IS NULL THEN
		p_tr_date := fn_get_current_trans_dt();
	END IF;
	
	IF p_tr_date < v_today_dt THEN
		p_msg := 'Please make sure night audit has been done, current transaction date: ' || p_tr_date::TEXT;
		RETURN;
	END IF;
	
	-- tr_type should be Eat-in, Take Away or Room Service
	IF LENGTH(COALESCE(p_tr_type, '')) = 0 THEN
		p_msg := 'Please select the Order Type!!';
		RETURN;
	END IF;
	
	IF p_tr_type = 'TS'
	AND LENGTH(COALESCE(p_table_no, '')) = 0 THEN
		p_msg := 'Must Select Table Number!!';
		RETURN;
	END IF;
	
-- 	IF NOT EXISTS (
-- 		SELECT guest_id
-- 		FROM tb_guest
-- 		WHERE guest_id = p_guest_id
-- 	) THEN
-- 		p_msg := 'Invalid Guest!!';
-- 		RETURN;
-- 	END IF;

	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF fn_to_guid(p_order_trans_id) <> fn_empty_guid() 
	AND NOT EXISTS (
		SELECT doc_no
		FROM tb_order_trans
		WHERE doc_no = p_doc_no
	) THEN
		
		-- Insert new order trans
		INSERT INTO tb_order_trans (
			order_trans_id, created_on, created_by, modified_on, modified_by, tr_date, tr_type, tr_status, 
			doc_no, guest_id, pax, table_no, room_no, delivery_time, delivery_next_day					   
		) VALUES (
			p_order_trans_id, v_now, p_current_uid, v_now, p_current_uid, p_tr_date, p_tr_type, p_tr_status,
			p_doc_no, p_guest_id, p_pax, p_table_no, p_room_no, p_delivery_time, p_delivery_next_day
		);
		
		audit_log := 'Create New Order: ' || p_doc_no;
	
	ELSE 
	
		IF NOT EXISTS (
			SELECT order_trans_id, doc_no
			FROM tb_order_trans
			WHERE order_trans_id = p_order_trans_id 
			AND doc_no = p_doc_no
		) THEN
			p_msg := 'The record not found!!';
			RETURN;
		END IF;
		
		-- Get old record for audit log purpose
		SELECT tr_type, tr_status, guest_id, pax, table_no, room_no, delivery_time, delivery_next_day
		INTO v_tr_type_old, v_tr_status_old, v_guest_id_old, v_pax_old, v_table_no_old, v_room_no_old, v_delivery_time_old, v_delivery_next_day_old
		FROM tb_order_trans
		WHERE 
			order_trans_id = p_order_trans_id 
			AND doc_no = p_doc_no;
			
		UPDATE tb_order_trans
		SET 
			tr_type = p_tr_type,
			tr_status = p_tr_status,
			guest_id = p_guest_id,
			pax = p_pax_id,
			table_no = p_table_no,
			room_no = p_room_no,
			delivery_time = p_delivery_time,
			delivery_next_day = p_delivery_next_day
		WHERE 
			order_trans_id = p_order_trans_id
			AND doc_no = p_doc_no;
			
		audit_log := 'Update Order Type from ' || v_tr_type_old || ' to ' || p_tr_type || ', ' ||
						'Update Transaction Status from ' || v_tr_status_old || ' to ' || p_tr_status || ', ' ||
						'Update Guest from ' || v_guest_id_old || ' to ' || p_guest_id || ', ' ||
						'Update Pax from ' || v_pax_old || ' to ' || p_pax || ', ' ||
						'Update Table No from ' || v_table_no_old || ' to ' || p_table_no || ', ' ||
						'Update Room No from ' || v_room_no_old || ' to ' || p_room_no || ', ' ||
						'Update Delivery Time from ' || v_delivery_time_old || ' to ' || p_delivery_time || ', ' ||
						'Update Delivery Next Day from ' || v_delivery_next_day_old || ' to ' || p_delivery_next_day || '.';
		
	END IF;
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_order_trans_save'
		, p_uid => p_current_uid
		, p_id1 => p_order_trans_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	); 
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_order_trans_save - end';
	END IF;

END
$BODY$;