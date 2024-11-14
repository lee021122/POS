CREATE OR REPLACE PROCEDURE pr_pos_trans_void_bill (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_order_trans_id uuid,
	IN p_override_remarks character varying(255),
	IN p_undo integer,
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
	v_now CONSTANT timestamp = current_timestamp;
	audit_log text;
	module_code text;
	v_tr_status_old character varying(50);
	v_doc_no_old character varying(50);
BEGIN 
/*

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_pos_trans_void_bill - start';
	END IF;
	
	module_code := 'Order - Void Bill';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF fn_to_guid(p_order_trans_id) = fn_empty_guid() 
	AND NOT EXISTS (
		SELECT order_trans_id
		FROM tb_order_trans
		WHERE order_trans_id = p_order_trans_id
	) THEN
		p_msg := 'Invalid Bill!!';
		RETURN;
	END IF;
	
	IF LENGTH(p_override_remarks, '') = 0 THEN
		p_msg := 'Override Reason cannot be blank!!';
		RETURN;
	END IF;
	
	SELECT tr_status, doc_no
	INTO v_tr_status_old, v_doc_no_old
	FROM tb_order_trans
	WHERE order_trans_id = p_order_trans_id;
	
	IF v_tr_status_old = 'X' THEN
		p_msg := 'This Bill has already been voided!!';
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	UPDATE tb_order_trans
	SET 
		tr_status = 'X'
	WHERE order_trans_id = p_order_trans_id;
	
	UPDATE tb_order_trans_item_line
	SET
		tr_status = 'X'
	WHERE order_trans_id = p_order_trans_id;
	 
	audit_log := 'Voided Bill Order #: ' || v_doc_no_old || '.';
	
	-- Create Notification
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_pos_trans_void_bill'
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
		RAISE NOTICE 'pr_pos_trans_void_bill - end';
	END IF;

END
$BODY$;