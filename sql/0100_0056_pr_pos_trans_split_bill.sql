CREATE OR REPLACE PROCEDURE pr_pos_trans_split_bill (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_order_trans_id uuid,
	IN p_move_to integer, 						-- '0' -> new doc_no, '1' -> existing doc_no
	IN p_move_by integer, 						-- '0' -> by percentage, '1' -> by amount
	IN p_move_value numeric(15, 2),
	IN p_product_ids text,
	IN p_rid integer,
	IN p_axn character varying(255),
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/*

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF fn_to_guid(p_order_trans_id) = fn_empty_guid() THEN 
		p_msg := 'Invalid Bill!!';
		RETURN;
	END IF;
	
	IF LENGTH(COALESCE(p_product_ids, '')) = 0 THEN
		p_msg := 'Please select product to split!!';
		RETURN;
	END IF;
	
	IF p_move_value <= 0 THEN
		p_msg := 'The ' || 
				CASE 
					WHEN p_move_by = 0 THEN ' Percentage must greater than 0!!'
					WHEN p_move_by = 1 THEN ' Amount must greater than 0!!'
					ELSE 'Value must greater than 0!!'
				END;
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF p_move_to = 1 THEN
	
	ELSE 
	
	END IF;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;