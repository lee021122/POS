insert into tb_action (action_id, action_code, action_desc, sql_q, group_code, is_in_use, display_seq, created_on, created_by) values
-- Module: Product
(gen_random_uuid(), 'prod-category::s', 'Product Category - Save', 'pr_prod_category_save', null, 1, '000001', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-category::l', 'Product Category - List', 'pr_prod_category_list', null, 1, '000002',  current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-category::d', 'Product Category - Delete', 'pr_prod_category_delete', null, 1, '000003', current_timestamp, 'admin'),
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


insert into tb_action_param (action_param_id, action_id, action_param_name, data_type, seq, is_compulsory, created_on, created_by) values
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'category_id', 'id', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'category_desc', 'string', 3, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'is_in_use', 'int', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'display_seq', 'string', 5, 0, current_timestamp, 'admin')

insert into tb_pricing_type (pricing_type_id, created_on, created_by, modified_on, modified_by, pricing_type_desc, is_in_use) values
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Fixed', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Variable', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'By Unit', 1)

