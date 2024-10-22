CREATE OR REPLACE PROCEDURE pr_order_trans_new (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_store_id uuid,
	IN p_tr_date date,
	OUT p_doc_no character varying(255),
	OUT p_order_trans_id uuid,
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_doc_no text;
BEGIN
/*
	
	CALL pr_order_trans_new (
		p_current_uid => 'a',
		p_msg => null,
		p_store_id => '0f49bfb0-6414-43f1-bdc6-8c97a7290e6d',
		p_tr_date => null,
		p_doc_no => null,
		p_order_trans_id => null
	)
	
*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF NOT EXISTS (
		SELECT store_id
		FROM tb_store
		WHERE store_id = p_store_id
	) THEN
		p_msg := 'Invalid Store!!';
		RETURN;
	END IF;
	
	IF p_tr_date IS NULL THEN
		p_tr_date := fn_get_current_trans_dt();
	END IF;
	
	IF p_tr_date < CURRENT_DATE THEN
		p_msg := 'Please make sure night audit has been done, current transaction date: ' || p_tr_date::TEXT;
		RETURN;
	END IF;

	-- -------------------------------------
	-- process
	-- -------------------------------------
	p_doc_no = fn_gen_new_doc_no(p_current_uid, null, p_store_id);
	
	p_order_trans_id := gen_random_uuid();
	
	IF p_doc_no IS NOT NULL AND p_order_trans_id IS NOT NULL THEN
		p_msg := 'ok';
		RETURN;
	ELSE 
		p_msg := 'Some Error Happen!!';
		p_doc_no := null;
		p_order_trans_id := null;
		RETURN;
	END IF;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;