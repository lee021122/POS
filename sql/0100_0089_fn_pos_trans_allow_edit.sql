CREATE OR REPLACE FUNCTION fn_pos_trans_allow_edit (
	p_current_uid character varying(255),
	p_order_trans_uid uuid,
	IN p_rid integer,
	IN p_axn character varying(255),
	IN p_url character varying(255),
	IN p_is_debug integer DEFAULT 0
) RETURNS INTEGER 
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	can_edit integer;
	v_tr_status character varying(255);
	v_outstanding numeric(15, 4);
BEGIN
/*

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	SELECT tr_status, outstanding_amt
    INTO v_tr_status, v_outstanding
    FROM tb_order_trans
    WHERE order_trans_id = p_order_trans_uid;
	
	IF v_tr_status = 'C' AND v_outstanding > 0 THEN 
       can_edit := 1;			-- Allow editing
	ELSE 
		can_edit := 0;
    END IF;
	
	RETURN can_edit;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	
END
$$;