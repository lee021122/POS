CREATE OR REPLACE PROCEDURE public.pr_product_save(
	IN p_current_uid character varying(255),
	OUT p_msg text,
	INOUT p_product_id uuid,
	IN p_product_desc character varying(255),
	IN p_product_code character varying(255),
	IN p_category_id uuid,
	IN p_product_tag character varying(255),
	IN p_product_img_path character varying(255),
	IN p_supplier_id uuid,
	IN p_pricing_type_id uuid,
	IN p_cost numeric(15, 4),
	IN p_sell_price numeric(15, 4),
	IN p_tax_code1 character varying(255),
	IN p_amt_include_tax1 integer,
	IN p_tax_code2 character varying(255),
	IN p_amt_include_tax2 integer,
	IN p_calc_tax2_after_tax1 integer,
	IN p_is_in_use integer,
	IN p_display_seq character varying(255),
	IN p_is_enable_kitchen_printer integer,
	IN p_is_allow_modifier integer,
	IN p_is_enable_track_stock integer,
	IN p_is_popular_item integer,
	IN p_is_debug integer DEFAULT 0)
    LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_now CONSTANT timestamp = localtimestamp;
	audit_log text;
	module_code text;
	v_final_price numeric(15, 4);
	v_unit_price numeric(15, 4);
	v_product_desc_old character varying;
	v_product_code_old character varying;
	v_category_id_old uuid;
	v_product_tag_old character varying;
	v_product_img_path_old character varying;
	v_supplier_id_old uuid;
	v_pricing_type_id_old uuid;
	v_cost_old numeric(15, 2);
	v_sell_price_old numeric(15, 2);
	v_tax_code1_old character varying;
	v_amt_include_tax1_old integer;
	v_tax_code2_old character varying;
	v_amt_include_tax2_old integer;
	v_calc_tax2_after_tax1_old integer;
	v_is_in_use_old integer;
	v_display_seq_old character varying;
	v_is_enable_kitchen_printer_old integer;
	v_is_allow_modifier_old integer;
	v_is_enable_track_stock_old integer;
	v_is_popular_item_old integer;
BEGIN
/* 0100_0007_pr_product_save
-- Save Product

	CALL public.pr_product_save(
        p_current_uid        => 'tester', 
        p_msg                => null,           
        p_product_id         => null,      
        p_product_desc       => 'Nasi Goreng Kampung', 
        p_product_code       => 'P0001',            
        p_category_id        => 'd437bedc-4e02-428c-a3e6-f4f873cbb675',
        p_product_tag        => null,           
        p_product_img_path   => '/path/to/image.jpg',  
        p_supplier_id        => null, 
        p_pricing_type_id    => '7301109c-cef9-4df0-9824-9e5d304ca49f', 
        p_cost               => 10,                
        p_sell_price         => null,               
        p_tax_code1          => 'SC',                
        p_amt_include_tax1   => 1,                     
        p_tax_code2          => 'SST-6%',                
        p_amt_include_tax2   => 1,                    
        p_calc_tax2_after_tax1 => 1,                  
        p_is_in_use          => 1,                     
        p_display_seq        => '000001',                 
        p_is_enable_kitchen_printer => 1,              
        p_is_allow_modifier  => 1,                     
        p_is_enable_track_stock => 1,                  
        p_is_popular_item    => 0               
    );
*/
	
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_product_save - start';
	END IF;
	
	module_code := 'Settings - Product';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF LENGTH(COALESCE(p_product_desc, '')) = 0 THEN 
		p_msg := 'Product Description cannot be blank!!';
		RETURN;
	END IF;
	
	IF EXISTS (
		SELECT *
		FROM tb_product
		WHERE 
			product_desc = p_product_desc
			AND product_id <> fn_to_guid(p_product_id)
	) THEN
		p_msg := 'Product Description: ' || p_product_desc || ' already exists!!';
		RETURN;
	END IF;
	
	IF EXISTS (
		SELECT *
		FROM tb_product
		WHERE 
			product_code = p_product_code
			AND product_id <> fn_to_guid(p_product_id)
	) THEN
		p_msg := 'Product Code: ' || p_product_code || ' already exists!!';
		RETURN;
	END IF;
	
	IF NOT EXISTS (
		SELECT *
		FROM tb_prod_category
		WHERE category_id = p_category_id
	) THEN
		p_msg := 'Invalid Product Category!!'; 
		RETURN;
	END IF;
	
-- 	IF NOT EXISTS (
-- 		SELECT *
-- 		FROM tb_supplier
-- 		WHERE supplier_id = p_supplier_id
-- 	) THEN
-- 		p_msg := 'Invalid Supplier ID!!';
-- 		RETURN;
-- 	END IF;
	
	IF NOT EXISTS (
		SELECT *
		FROM tb_pricing_type 
		WHERE pricing_type_id = p_pricing_type_id
	) THEN
		p_msg := 'Invalid Pricing Type';
		RETURN;
	END IF;
	
	IF NOT EXISTS (
		SELECT * 
		FROM tb_tax 
		WHERE tax_code = p_tax_code1 OR tax_code = p_tax_code2
	) THEN
		p_msg := 'Invalid Tax Code!!';
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	-- Calc the tax 
	SELECT final_price, unit_price
	INTO v_final_price, v_unit_price
	FROM fn_tax_calculation (
		p_tax_code1 => p_tax_code1,
		p_tax_code2 => p_tax_code2,
		p_tax_include_tax1 => p_amt_include_tax1, 
		p_tax_include_tax2 => p_amt_include_tax2, 
		p_calc_tax2_after_tax1 => p_calc_tax2_after_tax1, 
		p_qty => 1,
		p_amt => p_cost	
	);
	
	IF fn_to_guid(p_product_id) = fn_empty_guid() THEN
	
		p_product_id := gen_random_uuid();
		
		-- Insert new record
		INSERT INTO tb_product (
			product_id, created_on, created_by, modified_on, modified_by, product_desc, product_code, category_id, product_tag, product_img_path, supplier_id,
			pricing_type_id, cost, sell_price, tax_code1, amt_include_tax1, tax_code2, amt_include_tax2, calc_tax2_after_tax1, is_in_use, display_seq, 
			is_enable_kitchen_printer, is_allow_modifier, is_enable_track_stock, is_popular_item
		) VALUES (
			p_product_id, v_now, p_current_uid, v_now, p_current_uid, p_product_desc, p_product_code, p_category_id, p_product_tag, p_product_img_path, p_supplier_id,
			p_pricing_type_id, v_final_price, v_unit_price, p_tax_code1, p_amt_include_tax1, p_tax_code2, p_amt_include_tax2, p_calc_tax2_after_tax1, p_is_in_use, 
			p_display_seq, p_is_enable_kitchen_printer, p_is_allow_modifier, p_is_enable_track_stock, p_is_popular_item
		);
		
		-- Prepare the audit log
		audit_log = 'Create new product: ' || p_product_desc || ' successfully.';
		
	ELSE
		
		-- Get the old record for audit log purpose
		SELECT 
			product_desc, product_code, category_id, product_tag, product_img_path, supplier_id, pricing_type_id, cost, sell_price, tax_code1,
			amt_include_tax1, tax_code2, amt_include_tax2, calc_tax2_after_tax1, is_in_use, display_seq, is_enable_kitchen_printer, 
			is_allow_modifier, is_enable_track_stock, is_popular_item
		INTO 
			v_product_desc_old, v_product_code_old, v_category_id_old, v_product_tag_old, v_product_img_path_old, v_supplier_id_old, v_pricing_type_id_old, 
			v_cost_old, v_sell_price_old, v_tax_code1_old, v_amt_include_tax1_old, v_tax_code2_old, v_amt_include_tax2_old, v_calc_tax2_after_tax1_old, 
			v_is_in_use_old, v_display_seq_old, v_is_enable_kitchen_printer_old, v_is_allow_modifier_old, v_is_enable_track_stock_old, v_is_popular_item_old
		FROM tb_product
		WHERE product_id = p_product_id;
		
		-- Update the record
		UPDATE tb_product
		SET
			modified_on = v_now,
			modified_by = p_current_uid,
			product_desc = p_product_desc,
			product_code = p_product_code,
			category_id = p_category_id,
			product_tag = p_product_tag,
			product_img_path = p_product_img_path,
			supplier_id = p_supplier_id,
			pricing_type_id = p_pricing_type_id,
			cost = v_final_price,
			sell_price = v_unit_price,
			tax_code1 = p_tax_code1,
			amt_include_tax1 = p_amt_include_tax1,
			tax_code2 = p_tax_code2, 
			amt_include_tax2 = p_amt_include_tax2, 
			calc_tax2_after_tax1 = p_calc_tax2_after_tax1, 
			is_in_use = p_is_in_use,
			display_seq = p_display_seq,
			is_enable_kitchen_printer = p_is_enable_kitchen_printer, 
			is_allow_modifier = p_is_allow_modifier, 
			is_enable_track_stock = p_is_enable_track_stock, 
			is_popular_item = p_is_popular_item
		WHERE product_id = p_product_id;
		
		-- Prepared Audit Log
		audit_log = 'Updated Product Description from ' || v_product_desc_old || ' to ' || p_product_desc || ', ' ||
					'Updated Product Code from ' || v_product_code_old || ' to ' || p_product_code || ', ' ||
					'Updated Category from' || v_category_id_old || ' to ' || p_category_id || ', ' ||
					'Updated Product Tag from ' || v_product_tag_old || ' to ' || p_product_tag || ', ' ||
					'Updated Product Image Path from ' || v_product_img_path_old || ' to ' || p_product_img_path || ', ' ||
					'Updated Supplier from ' || v_supplier_id_old || ' to ' || p_supplier_id || ', ' ||
					'Updated Pricing Type from ' || v_pricing_type_id_old || ' to ' || p_pricing_type_id || ', ' ||
					'Updated Cost from ' || v_cost_old || ' to ' || p_cost || ', ' ||
					'Updated Sell Price from ' || v_sell_price_old || ' to ' || v_unit_price || ', ' ||
					'Updated Tax Code 1 from ' || v_tax_code1_old || ' to ' || p_tax_code1 || ', ' ||
					'Updated Amount Include Tax 1 from ' || v_amt_include_tax1_old || ' to ' || p_amt_include_tax1 || ', ' ||
					'Updated Tax Code 2 from ' || v_tax_code2_old || ' to ' || p_tax_code2 || ', ' ||
					'Updated Amount Include Tax 2 from ' || v_amt_include_tax2_old || ' to ' || p_amt_include_tax2 || ', ' ||
					'Updated Calc Tax 2 after Tax 1 from ' || v_calc_tax2_after_tax1_old || ' to ' || p_calc_tax2_after_tax1 || ', ' ||
					'Updated Is Active from ' || v_is_in_use_old || ' to ' || p_is_in_use || ', ' ||
					'Updated Display Sequence from ' || v_display_seq_old || ' to ' || p_display_seq || ', ' ||
					'Updated Enbale Kitchen Printer from ' || v_is_enable_kitchen_printer_old || ' to ' || p_is_enable_kitchen_printer || ', ' ||
					'Updated Allow Modifier from ' || v_is_allow_modifier_old || ' to ' || p_is_allow_modifier || ', ' ||
					'Updated Enable Track Stock from ' || v_is_enable_track_stock_old || ' to ' || p_is_enable_track_stock || ', ' ||
					'Updated Is Popular Item from ' || v_is_popular_item_old || ' to ' || p_is_popular_item || '.'; 
	END IF;
	
	p_msg = 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_product_save'
		, p_uid => p_current_uid
		, p_id1 => p_product_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	);
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_product_save - end';
	END IF;
	
END
$BODY$;