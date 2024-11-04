CREATE OR REPLACE FUNCTION fn_gen_new_doc_no (
	p_current_uid character varying(255),
	p_tr_type character varying(50),
	p_store_id uuid
)
RETURNS text
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_prefix text;
	v_current_dt date;
	v_len int;
	v_doc_no text;
	v_order_count int;
	audit_log text;
	module_code text;
BEGIN
/*
	
	select *
	from fn_gen_new_doc_no (
		'a',
		'TS',
		'0f49bfb0-6414-43f1-bdc6-8c97a7290e6d'
	)
	
*/

	module_code := 'Order';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF NOT EXISTS (
		SELECT tr_type_code
		FROM tb_tr_type
		WHERE tr_type_code = p_tr_type
	) THEN
		RAISE EXCEPTION 'Invalid Transaction Type!!';
	END IF;
	
	IF p_store_id IS NULL THEN
		RAISE EXCEPTION 'Store ID cannot be blank!!';
	END IF;

	IF NOT EXISTS (
		SELECT store_id
		FROM tb_store
		WHERE store_id = p_store_id
	) THEN
		RAISE EXCEPTION 'Invalid Store ID!!';
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	v_current_dt = (SELECT sys_setting_value::DATE FROM tb_sys_setting WHERE sys_setting_title = 'CURRENT_TRANS_DATE');
	v_len = (SELECT sys_setting_value::INTEGER FROM tb_sys_setting WHERE sys_setting_title = 'ORDER_NO_LENGTH');
	v_order_count = (select count(*) from tb_order_trans where tr_date = v_current_dt);
	
	v_doc_no = COALESCE(p_tr_type, '') || TO_CHAR(v_current_dt, 'YYYYMMDD') || LPAD((COALESCE(v_order_count, 0) + 1)::text, v_len, '0');
	
	RETURN v_doc_no;
	
	audit_log := 'Generate new order no: ' || v_doc_no || '.';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'fn_gen_new_doc_no'
		, p_uid => p_current_uid
		, p_id1 => v_doc_no
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	);
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;