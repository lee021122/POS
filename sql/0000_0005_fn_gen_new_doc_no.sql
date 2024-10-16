CREATE OR REPLACE FUNCTION fn_gen_new_doc_no (
	p_current_uid character varying(255),
	p_co_id uuid,
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
BEGIN
/*
	
	select *
	from fn_gen_new_doc_no (
		'a',
		null,
		'0f49bfb0-6414-43f1-bdc6-8c97a7290e6d'
	)
	
*/
	-- -------------------------------------
	-- validation
	-- -------------------------------------
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
	
	v_prefix = (SELECT sys_setting_value FROM tb_sys_setting WHERE sys_setting_title = 'ORDER_NO_PREFIX');
	v_current_dt = (SELECT sys_setting_value::DATE FROM tb_sys_setting WHERE sys_setting_title = 'CURRENT_TRANS_DATE');
	v_len = (SELECT sys_setting_value::INTEGER FROM tb_sys_setting WHERE sys_setting_title = 'ORDER_NO_LENGTH');
	v_order_count = (select count(*) from tb_order_trans where tr_date = v_current_dt);
	
	v_doc_no = COALESCE(v_prefix, '') || TO_CHAR(CURRENT_DATE, 'YYYYMMDD') || LPAD((COALESCE(v_order_count, 0) + 1)::text, v_len, '0');
	
	RETURN v_doc_no;
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;