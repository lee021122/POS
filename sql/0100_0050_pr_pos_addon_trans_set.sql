CREATE OR REPLACE PROCEDURE pr_pos_addon_trans_set (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_order_trans_id uuid,
	IN p_order_trans_item_line_id uuid,
	IN p_modifier_option_id uuid,
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
	p_order_trans_modifier_id uuid;
	v_product_id uuid;
BEGIN
/* 0100_0050_pr_pos_addon_trans_set
	
*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_pos_addon_trans_set - start';
	END IF;
	
	module_code := 'Order - Addon Item Line';

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF fn_to_guid(p_modifier_option_id) = fn_empty_guid() THEN
		p_msg := 'Modifier Option cannot be blank!!';
		RETURN;
	ELSIF NOT EXISTS (
		SELECT 1
		FROM tb_modifier_option
		WHERE modifier_option_id = p_modifier_option_id
	) THEN
		p_msg := 'Invalid Modifier Option!!';
		RETURN;
	END IF;	
	
	SELECT product_id
	INTO v_product_id
	FROM tb_order_trans_item_line
	WHERE 
		order_trans_id = p_order_trans_id
		AND order_trans_item_line_id = p_order_trans_item_line_id;
		
	IF v_product_id IS NULL THEN
		p_msg := 'Invalid Item Line!!';
		RETURN;
	END IF;

	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF EXISTS (
		SELECT a.modifier_option_id
		FROM tb_modifier_option a
		INNER JOIN tb_modifier_group b ON b.modifier_group_id = a.modifier_group_id
		WHERE 
			a.modifier_option_id = p_modifier_option_id
			AND b.is_multiple_modifier_choice = 1
	) THEN 
	
		-- handle is_multiple_modifier_choice
		p_order_trans_modifier_id := gen_random_uuid();
		
		INSERT INTO tb_order_trans_modifier (
			order_trans_modifier_id, order_trans_id, order_trans_item_line_id, modifier_option_id, created_on, created_by, modified_on, modified_by
		) VALUES (
			p_order_trans_modifier_id, p_order_trans_id, p_order_trans_item_line_id, p_modifier_option_id, v_now, p_current_uid, v_now, p_current_uid
		);
		
		audit_log := 'Added modifier option: ' || p_modifier_option_id || '.';
	
	ELSE
	
		-- Handle is_single_modifier_choice
		IF EXISTS (
			SELECT modifier_option_id 
			FROM tb_order_trans_modifier
			WHERE 
				order_trans_id = p_order_trans_id
				AND order_trans_item_line_id = p_order_trans_item_line_id
		) THEN
			p_msg := 'The product only allow single modifier option!!';
			RETURN;
		ELSE
		
			p_order_trans_modifier_id := gen_random_uuid();
		
			INSERT INTO tb_order_trans_modifier (
				order_trans_modifier_id, order_trans_id, order_trans_item_line_id, modifier_option_id, created_on, created_by, modified_on, modified_by
			) VALUES (
				p_order_trans_modifier_id, p_order_trans_id, p_order_trans_item_line_id, p_modifier_option_id, v_now, p_current_uid, v_now, p_current_uid
			);

			audit_log := 'Added modifier option: ' || p_modifier_option_id || '.';

		END IF;
	
	END IF;
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_pos_addon_trans_set'
		, p_uid => p_current_uid
		, p_id1 => p_order_trans_modifier_id
		, p_id2 => null
		, p_id3 => null
     	, p_app_id => null
		, p_module_code => module_code
	); 

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_pos_addon_trans_set - end';
	END IF;

END
$BODY$;