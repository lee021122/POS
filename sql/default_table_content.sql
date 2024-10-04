insert into tb_action (action_id, action_code, action_desc, sql_q, group_code, is_in_use, display_seq, created_on, created_by) values
-- Module: Product
-- (gen_random_uuid(), 'prod-category::s', 'Product Category - Save', 'pr_prod_category_save', null, 1, '000001', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-category::l', 'Product Category - List', 'pr_prod_category_list', null, 1, '000002',  current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-category::d', 'Product Category - Delete', 'pr_prod_category_delete', null, 1, '000003', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-setup::s', 'Product - Save', 'pr_product_save', null, 1, '000004', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-setup::l', 'Product - List', 'pr_product_list', null, 1, '000005',  current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-setup::d', 'Product - Delete', 'pr_product_delete', null, 1, '000006', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-modifier-grp::s', 'Product Modifier Group - Save', 'pr_product_modifier_group_save', null, 1, '000004', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-modifier-grp::l', 'Product Modifier Group - List', 'pr_product__list', null, 1, '000005',  current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-modifier-grp::d', 'Product Modifier Group - Delete', 'pr_product_delete', null, 1, '000006', current_timestamp, 'admin'),
-- Module: Settings
(gen_random_uuid(), 'setting-general::s', 'Settings General - Save', 'pr_general_setting_save', null, 1, '000004', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-store::s', 'Settings Store - Save', 'pr_store_save', null, 1, '000005', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-store::l', 'Settings Store - List', 'pr_store_list', null, 1, '000006', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-store::d', 'Settings Store - Delete', 'pr_store_delete', null, 1, '000007', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-tax::s', 'Settings Tax - Save', 'pr_tax_save', null, 1, '000008', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-tax::l', 'Settings Tax - List', 'pr_tax_list', null, 1, '000009', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-tax::d', 'Settings Tax - Delete', 'pr_tax_delete', null, 1, '000010', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-pymt-mode::s', 'Settings Payment Mode - Save', 'pr_pymt_mode_save', null, 1, '000011', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-pymt-mode::l', 'Settings Payment Mode - List', 'pr_pymt_mode_list', null, 1, '000012', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-pymt-mode::d', 'Settings Payment Mode - Delete', 'pr_pymt_mode_delete', null, 1, '000013', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-meal-period::s', 'Settings Meal Period - Save', 'pr_meal_period_save', null, 1, '000014', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-meal-period::l', 'Settings Meal Period - List', 'pr_meal_period_list', null, 1, '000015', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-meal-period::d', 'Settings Meal Period - Delete', 'pr_meal_period_delete', null, 1, '000016', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-receipt-temp::s', 'Settings Receipt Template - Save', 'pr_receipt_temp_save', null, 1, '000017', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-receipt-temp::l', 'Settings Receipt Template - List', 'pr_receipt_temp_list', null, 1, '000018', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-receipt-temp::d', 'Settings Receipt Template - Delete', 'pr_receipt_temp_delete', null, 1, '000019', current_timestamp, 'admin'),
-- Module: Customer
(gen_random_uuid(), 'app-customer::s', 'Customer - Save', 'pr_guest_save', null, 1, '000020', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-customer::l', 'Customer - List', 'pr_guest_list', null, 1, '000021', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-customer::d', 'Customer - Delete', 'pr_guest_delete', null, 1, '000022', current_timestamp, 'admin'),
-- Module: Supplier
(gen_random_uuid(), 'app-supplier::s', 'Supplier - Save', 'pr_supplier_save', null, 1, '000023', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-supplier::l', 'Supplier - List', 'pr_supplier_list', null, 1, '000024', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-supplier::d', 'Supplier - Delete', 'pr_supplier_delete', null, 1, '000025', current_timestamp, 'admin'),
select * from tb_action

insert into tb_action_param (action_param_id, action_id, action_param_name, data_type, seq, is_compulsory, created_on, created_by) values
-- -- prod-category::s
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'category_id', 'id', 3, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'category_desc', 'string', 4, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'is_in_use', 'int', 5, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'display_seq', 'string', 6, 0, current_timestamp, 'admin'),
-- -- prod-category::l
-- -- prod-category::d
-- (gen_random_uuid(), '4a5903ed-330f-47dd-9c82-6be0f7a1bf80', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), '4a5903ed-330f-47dd-9c82-6be0f7a1bf80', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '4a5903ed-330f-47dd-9c82-6be0f7a1bf80', 'category_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-receipt-temp::s
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'receipt_temp_id', 'id', 3, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'receipt_temp_name', 'string', 4, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'logo_img_path', 'string', 5, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'extra_information', 'text', 6, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_store_name', 'integer', 7, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_store_details', 'integer', 8, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_customer_details', 'integer', 9, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_customer_point', 'integer', 10, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_in_use', 'integer', 11, 0, current_timestamp, 'admin'),

-- prod-setup::s
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_product_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_product_desc', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_product_code', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_categroy_id', 'id', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_product_tag', 'id', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_product_img_path', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_supplier_id', 'id', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_cost', 'money', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_sell_price', 'money', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_tax_code1', 'string', 12, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_amt_include_tax1', 'int', 13, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_tax_code2', 'string', 14, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_amt_include_tax2', 'int', 15, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_calc_tax2_after_tax1', 'int', 16, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_is_in_use', 'int', 17, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_display_seq', 'string', 18, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_is_enable_kitchen_printer', 'int', 19, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_is_allow_modifier', 'int', 20, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_is_enable_track_stock', 'int', 21, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'p_is_popular_item', 'int', 12, 0, current_timestamp, 'admin'),
-- prod-setup::l
-- prod-setup::d

insert into tb_pricing_type (pricing_type_id, created_on, created_by, modified_on, modified_by, pricing_type_desc, is_in_use) values
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Fixed', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Variable', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'By Unit', 1)

