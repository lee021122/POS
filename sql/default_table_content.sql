insert into tb_action (action_id, action_code, action_desc, sql_q, group_code, is_in_use, display_seq, created_on, created_by) values
-- Module: Product
-- (gen_random_uuid(), 'prod-category::s', 'Product Category - Save', 'pr_prod_category_save', null, 1, '000001', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-category::l', 'Product Category - List', 'pr_prod_category_list', null, 1, '000002',  current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-category::d', 'Product Category - Delete', 'pr_prod_category_delete', null, 1, '000003', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-setup::s', 'Product - Save', 'pr_product_save', null, 1, '000004', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-setup::l', 'Product - List', 'pr_product_list', null, 1, '000005',  current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-setup::d', 'Product - Delete', 'pr_product_delete', null, 1, '000006', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-modifier-grp::s', 'Product Modifier Group - Save', 'pr_product_modifier_group_save', null, 1, '000004', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-modifier-grp::l', 'Product Modifier Group - List', 'pr_product__list', null, 1, '000005',  current_timestamp, 'admin'),
-- (gen_random_uuid(), 'prod-modifier-grp::d', 'Product Modifier Group - Delete', 'pr_product_delete', null, 1, '000006', current_timestamp, 'admin'),
-- Module: Settings
-- (gen_random_uuid(), 'setting-general::s', 'Settings General - Save', 'pr_general_setting_save', null, 1, '000004', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-store::s', 'Settings Store - Save', 'pr_store_save', null, 1, '000005', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-store::l', 'Settings Store - List', 'pr_store_list', null, 1, '000006', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-store::d', 'Settings Store - Delete', 'pr_store_delete', null, 1, '000007', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-tax::s', 'Settings Tax - Save', 'pr_tax_save', null, 1, '000008', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-tax::l', 'Settings Tax - List', 'pr_tax_list', null, 1, '000009', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-tax::d', 'Settings Tax - Delete', 'pr_tax_delete', null, 1, '000010', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-pymt-mode::s', 'Settings Payment Mode - Save', 'pr_pymt_mode_save', null, 1, '000011', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-pymt-mode::l', 'Settings Payment Mode - List', 'pr_pymt_mode_list', null, 1, '000012', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-pymt-mode::d', 'Settings Payment Mode - Delete', 'pr_pymt_mode_delete', null, 1, '000013', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-meal-period::s', 'Settings Meal Period - Save', 'pr_meal_period_save', null, 1, '000014', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-meal-period::l', 'Settings Meal Period - List', 'pr_meal_period_list', null, 1, '000015', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-meal-period::d', 'Settings Meal Period - Delete', 'pr_meal_period_delete', null, 1, '000016', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-receipt-temp::s', 'Settings Receipt Template - Save', 'pr_receipt_temp_save', null, 1, '000017', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-receipt-temp::l', 'Settings Receipt Template - List', 'pr_receipt_temp_list', null, 1, '000018', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-receipt-temp::d', 'Settings Receipt Template - Delete', 'pr_receipt_temp_delete', null, 1, '000019', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-table-sec::s', 'Settings Table Section - Save', 'pr_table_section_save', null, 1, '000026', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-table-sec::l', 'Settings Table Section - List', 'pr_table_section_list', null, 1, '000027', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-table-sec::d', 'Settings Table Section - Delete', 'pr_table_section_delete', null, 1, '000028', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-table::s', 'Settings Table - Save', 'pr_table_save', null, 1, '000029', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-table::l', 'Settings Table - List', 'pr_table_list', null, 1, '000030', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'setting-table::d', 'Settings Table - Delete', 'pr_table_delete', null, 1, '000031', current_timestamp, 'admin'),
-- Module: Customer
-- (gen_random_uuid(), 'app-customer::s', 'Customer - Save', 'pr_guest_save', null, 1, '000020', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'app-customer::l', 'Customer - List', 'pr_guest_list', null, 1, '000021', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'app-customer::d', 'Customer - Delete', 'pr_guest_delete', null, 1, '000022', current_timestamp, 'admin'),
-- Module: Supplier
-- (gen_random_uuid(), 'app-supplier::s', 'Supplier - Save', 'pr_supplier_save', null, 1, '000023', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'app-supplier::l', 'Supplier - List', 'pr_supplier_list', null, 1, '000024', current_timestamp, 'admin'),
-- (gen_random_uuid(), 'app-supplier::d', 'Supplier - Delete', 'pr_supplier_delete', null, 1, '000025', current_timestamp, 'admin'),
-- Module: Users
(gen_random_uuid(), 'app-user-group::s', 'User Group - Save', 'pr_user_group_save', null, 1, '000032', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-user-group::l', 'User Group - List', 'pr_user_group_list', null, 1, '000033', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-user-group-ac::s', 'User Group Action - Save', 'pr_user_group_action_save', null, 1, '000034', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-user-group-ac::l', 'User Group Action - List', 'pr_user_group_action_list', null, 1, '000035', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-users::s', 'Users - Save', 'pr_user_save', null, 1, '000036', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-users::l', 'Users - List', 'pr_user_save', null, 1, '000037', current_timestamp, 'admin'),

insert into tb_action_param (action_param_id, action_id, action_param_name, data_type, seq, is_compulsory, created_on, created_by) values
-- app-user-group::s
(gen_random_uuid(), '49d14601-c74e-4bb2-9e6d-7538c30fc4ec', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '49d14601-c74e-4bb2-9e6d-7538c30fc4ec', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '49d14601-c74e-4bb2-9e6d-7538c30fc4ec', 'user_group_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '49d14601-c74e-4bb2-9e6d-7538c30fc4ec', 'user_group_desc', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '49d14601-c74e-4bb2-9e6d-7538c30fc4ec', 'is_in_use', 'int', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '49d14601-c74e-4bb2-9e6d-7538c30fc4ec', 'display_seq', 'string', 6, 0, current_timestamp, 'admin'),
-- app-user-group::l

-- app-user-group-ac::s
(gen_random_uuid(), 'b0f87455-1661-4fc9-b94b-5fe81709d339', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'b0f87455-1661-4fc9-b94b-5fe81709d339', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'b0f87455-1661-4fc9-b94b-5fe81709d339', 'user_group_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'b0f87455-1661-4fc9-b94b-5fe81709d339', 'action_id', 'id', 4, 0, current_timestamp, 'admin'),
-- app-user-group-ac::l

-- app-users::s
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'user_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'login_id', 'text', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'user_name', 'text', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'email', 'text', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'pwd', 'text', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'user_group_id', 'id', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'f9ebd007-3afa-45e9-a018-719f8257a9dc', 'is_active', 'int', 9, 0, current_timestamp, 'admin'),
-- app-users::l

-- prod-category::s
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'category_id', 'id', 3, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'category_desc', 'string', 4, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'is_in_use', 'int', 5, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'display_seq', 'string', 6, 0, current_timestamp, 'admin'),
-- prod-category::l
-- (gen_random_uuid(), 'a7430527-905f-4e8c-bd7d-eb15e60ff87e', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'a7430527-905f-4e8c-bd7d-eb15e60ff87e', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
-- prod-category::d
-- (gen_random_uuid(), '4a5903ed-330f-47dd-9c82-6be0f7a1bf80', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), '4a5903ed-330f-47dd-9c82-6be0f7a1bf80', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '4a5903ed-330f-47dd-9c82-6be0f7a1bf80', 'category_id', 'id', 3, 0, current_timestamp, 'admin'),

-- prod-setup::s
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'product_id', 'id', 3, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'product_desc', 'string', 4, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'product_code', 'string', 5, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'category_id', 'id', 6, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'product_tag', 'string', 7, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'product_img_path', 'string', 8, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'supplier_id', 'id', 9, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'pricing_type_id', 'id', 10, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'cost', 'money', 11, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'sell_price', 'money', 12, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'tax_code1', 'string', 13, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'amt_include_tax1', 'int', 14, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'tax_code2', 'string', 15, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'amt_include_tax2', 'int', 16, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'calc_tax2_after_tax1', 'int', 17, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'is_in_use', 'int', 18, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'display_seq', 'string', 19, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'is_enable_kitchen_printer', 'int', 20, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'is_allow_modifier', 'int', 21, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'is_enable_track_stock', 'int', 22, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), 'e20b2f51-e2af-407d-b511-3e15f0186f36', 'is_popular_item', 'int', 23, 0, current_timestamp, 'admin'),
-- prod-setup::l
-- (gen_random_uuid(), '372d4765-1e82-487e-81f7-664e6185ffdb', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), '372d4765-1e82-487e-81f7-664e6185ffdb', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '372d4765-1e82-487e-81f7-664e6185ffdb', 'axn', 'string', 3, 0, current_timestamp, 'admin'),
-- prod-setup::d
-- (gen_random_uuid(), '5fc57803-79d2-4983-a966-ed146e352591', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), '5fc57803-79d2-4983-a966-ed146e352591', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '5fc57803-79d2-4983-a966-ed146e352591', 'product_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-general::s
(gen_random_uuid(), '3400476f-e613-47c1-a3eb-1bce92766903', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '3400476f-e613-47c1-a3eb-1bce92766903', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '3400476f-e613-47c1-a3eb-1bce92766903', 'setting_title', 'text', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '3400476f-e613-47c1-a3eb-1bce92766903', 'setting_value', 'text', 4, 0, current_timestamp, 'admin'),
-- setting-general::l

-- setting-store::s
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'store_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'store_name', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'addr_line_1', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'addr_line_2', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'city', 'string', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'state', 'id', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'post_code', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'country', 'id', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'phone_number', 'string', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'email', 'string', 12, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'website', 'string', 13, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'gst_id', 'string', 14, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'sst_id', 'string', 15, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'business_registration_num', 'string', 16, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '0edb75d8-b123-4bef-8745-3910125824ed', 'receipt_temp_id', 'id', 17, 0, current_timestamp, 'admin'),

-- setting-store::l
-- setting-store::d
(gen_random_uuid(), '79f54cbd-4a8b-44da-a4a3-bb444ddcbfda', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '79f54cbd-4a8b-44da-a4a3-bb444ddcbfda', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '79f54cbd-4a8b-44da-a4a3-bb444ddcbfda', 'store_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-tax::s
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'tax_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'tax_code', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'tax_desc', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'tax_pct', 'money', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'is_in_use', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'eda38ea1-b4e4-44c3-b4f3-98b594fe2869', 'display_seq', 'string', 8, 0, current_timestamp, 'admin'),
-- setting-tax::l
-- setting-tax::d
(gen_random_uuid(), 'bba365bd-b5b1-418c-9a01-c503808fa5bd', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'bba365bd-b5b1-418c-9a01-c503808fa5bd', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'bba365bd-b5b1-418c-9a01-c503808fa5bd', 'tax_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-pymt-mode::s
(gen_random_uuid(), 'ab3a1a09-4c0d-40c8-a960-6c6b478c93e1', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'ab3a1a09-4c0d-40c8-a960-6c6b478c93e1', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'ab3a1a09-4c0d-40c8-a960-6c6b478c93e1', 'pymt_mode_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'ab3a1a09-4c0d-40c8-a960-6c6b478c93e1', 'pymt_mode_desc', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'ab3a1a09-4c0d-40c8-a960-6c6b478c93e1', 'pymt_type', 'id', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'ab3a1a09-4c0d-40c8-a960-6c6b478c93e1', 'for_store', 'text', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'ab3a1a09-4c0d-40c8-a960-6c6b478c93e1', 'is_in_use', 'int', 7, 0, current_timestamp, 'admin'),
-- setting-pymt-mode::l
-- setting-pymt-mode::d
(gen_random_uuid(), '8e8b6822-9f7f-410b-a7cd-e3e7083101b2', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '8e8b6822-9f7f-410b-a7cd-e3e7083101b2', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '8e8b6822-9f7f-410b-a7cd-e3e7083101b2', 'pymt_mode_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-meal-period::s
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'meal_period_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'meal_period_desc', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'start_time', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'end_time', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'is_in_use', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'd23a4647-0ab2-4e02-a4e9-ff87fbcd10fc', 'display_seq', 'string', 8, 0, current_timestamp, 'admin'),
-- setting-meal-period::l
-- setting-meal-period::d
(gen_random_uuid(), '4227a31c-c70a-4dd8-8329-17802aac53fb', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '4227a31c-c70a-4dd8-8329-17802aac53fb', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '4227a31c-c70a-4dd8-8329-17802aac53fb', 'meal_period_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-receipt-temp::s
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'receipt_temp_id', 'id', 3, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'receipt_temp_name', 'string', 4, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'logo_img_path', 'string', 5, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'extra_information', 'text', 6, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_store_name', 'int', 7, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_store_details', 'int', 8, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_customer_details', 'int', 9, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_show_customer_point', 'int', 10, 0, current_timestamp, 'admin'),
-- (gen_random_uuid(), '9604d85e-0c7c-4538-acd9-9a519bf8de70', 'is_in_use', 'integer', 11, 0, current_timestamp, 'admin'),
-- setting-receipt-temp::l
-- setting-receipt-temp::d
(gen_random_uuid(), '8a14270f-5299-4bae-9145-fd5f81384080', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '8a14270f-5299-4bae-9145-fd5f81384080', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '8a14270f-5299-4bae-9145-fd5f81384080', 'receipt_temp_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-table-sec::s
(gen_random_uuid(), 'adc7eb8c-05d4-4499-a9b7-831f2c946b22', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'adc7eb8c-05d4-4499-a9b7-831f2c946b22', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'adc7eb8c-05d4-4499-a9b7-831f2c946b22', 'table_section_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'adc7eb8c-05d4-4499-a9b7-831f2c946b22', 'table_section_name', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'adc7eb8c-05d4-4499-a9b7-831f2c946b22', 'is_in_use', 'int', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'adc7eb8c-05d4-4499-a9b7-831f2c946b22', 'display_seq', 'string', 6, 0, current_timestamp, 'admin'),
-- setting-table-sec::l
-- setting-table-sec::d
(gen_random_uuid(), '35152829-1b34-418e-948b-b4df4a46ce4b', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '35152829-1b34-418e-948b-b4df4a46ce4b', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '35152829-1b34-418e-948b-b4df4a46ce4b', 'table_section_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-table::s
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'table_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'table_desc', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'table_section_id', 'id', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'qr_code', 'text', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'is_in_use', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '2154b20c-e396-4939-88f4-20953711dcfe', 'display_seq', 'string', 8, 0, current_timestamp, 'admin'),
-- setting-table::l
-- setting-table::d
(gen_random_uuid(), '5e69dabf-105e-49ba-a023-a84113b8b311', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '5e69dabf-105e-49ba-a023-a84113b8b311', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '5e69dabf-105e-49ba-a023-a84113b8b311', 'table_id', 'id', 3, 0, current_timestamp, 'admin'),

-- app-customer::s
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'guest_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'first_name', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'last_name', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'full_name', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'title', 'string', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'gender', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'phone_number', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'email', 'string', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'dob', 'dt', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'addr_line_1', 'string', 12, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'addr_line_2', 'string', 13, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'city', 'string', 14, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'state', 'id', 15, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'post_code', 'string', 16, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'country', 'id', 17, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'c0e60efa-b6a0-4812-90dd-240e83a09540', 'guest_tag', 'string', 18, 0, current_timestamp, 'admin'),
-- app-customer::l
-- app-customer::d
(gen_random_uuid(), '94a3ea77-db62-413a-9e0d-7f315ca1089d', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '94a3ea77-db62-413a-9e0d-7f315ca1089d', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '94a3ea77-db62-413a-9e0d-7f315ca1089d', 'guest_id', 'id', 3, 0, current_timestamp, 'admin'),

-- app-supplier::s
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'supplier_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'supplier_name', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'phone_number', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'mobile_number', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'email', 'string', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'fax', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'addr_line_1', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'addr_line_2', 'string', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'city', 'string', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'state', 'id', 12, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'post_code', 'string', 13, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'country', 'id', 14, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '1d03ff0f-284e-489c-9ce9-92e4c759b2dd', 'display_seq', 'string', 15, 0, current_timestamp, 'admin'),
-- app-supplier::l
-- app-supplier::d
(gen_random_uuid(), '43df3ae0-f0a8-448e-b58c-81b20fe4b7b2', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '43df3ae0-f0a8-448e-b58c-81b20fe4b7b2', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '43df3ae0-f0a8-448e-b58c-81b20fe4b7b2', 'supplier_id', 'id', 3, 0, current_timestamp, 'admin')

insert into tb_pricing_type (pricing_type_id, created_on, created_by, modified_on, modified_by, pricing_type_desc, is_in_use) values
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Fixed', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Variable', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'By Unit', 1)

insert into tb_country (country_id, created_on, created_by, country_name, country_code, is_in_use, display_seq) VALUES
(gen_random_uuid(), current_timestamp, 'admin', 'Malaysia', 'MY', 1, '000001'),
(gen_random_uuid(), current_timestamp, 'admin', 'Singapore', 'SG', 1, '000002'),
(gen_random_uuid(), current_timestamp, 'admin', 'Thailand', 'TH', 1, '000003');

insert into tb_state (state_id, created_on, created_by, state_name, is_in_use, display_seq) values 
(gen_random_uuid(), current_timestamp, 'admin', 'Kuala Lumpur', 1, '000001'),
(gen_random_uuid(), current_timestamp, 'admin', 'Putrajaya', 1, '000002'),
(gen_random_uuid(), current_timestamp, 'admin', 'Selangor', 1, '000003'),
(gen_random_uuid(), current_timestamp, 'admin', 'Johor', 1, '000004'),
(gen_random_uuid(), current_timestamp, 'admin', 'Melaka', 1, '000005'),
(gen_random_uuid(), current_timestamp, 'admin', 'Negeri Sembilan', 1, '000006'),
(gen_random_uuid(), current_timestamp, 'admin', 'Pahang', 1, '000007'),
(gen_random_uuid(), current_timestamp, 'admin', 'Terengganu', 1, '000008'),
(gen_random_uuid(), current_timestamp, 'admin', 'Perak', 1, '000009'),
(gen_random_uuid(), current_timestamp, 'admin', 'Penang', 1, '000010'),
(gen_random_uuid(), current_timestamp, 'admin', 'Kelantan', 1, '000011'),
(gen_random_uuid(), current_timestamp, 'admin', 'Perlis', 1, '000012'),
(gen_random_uuid(), current_timestamp, 'admin', 'Kedah', 1, '000013'),
(gen_random_uuid(), current_timestamp, 'admin', 'Sarawak', 1, '000014'),
(gen_random_uuid(), current_timestamp, 'admin', 'Sabah', 1, '000015')

insert into tb_sys_setting (created_on, created_by, modified_on, modified_by, sys_setting_title, sys_setting_value) values 
(current_timestamp, 'admin', current_timestamp, 'admin', 'CURRENT_TRANS_DATE', '2024-10-16'),
--(current_timestamp, 'admin', current_timestamp, 'admin', 'ORDER_NO_PREFIX', 'OR-'),
(current_timestamp, 'admin', current_timestamp, 'admin', 'ORDER_NO_LENGTH', '5'),
-- Pay-first or Pay-later
(current_timestamp, 'admin', current_timestamp, 'admin', 'OPERATION_MODE', ''),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_server', ''),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_port', ''),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_mailbox_id', ''),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_mailbox_pwd', ''),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_use_ssl', ''),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_able_service', ''),
-- Default (sell as much as) or set daily availability
(current_timestamp, 'admin', current_timestamp, 'admin', 'QR_ORDER_AVAILABILITY', '')


INSERT into tb_tr_type (tr_type_id, created_on, created_by, modified_on, modified_by, tr_type_code, tr_type_desc, is_in_use, display_seq) VALUES
(1, current_timestamp, 'admin', current_timestamp, 'admin', 'TS', 'Table Secvice', 1, '000001'),
(2, current_timestamp, 'admin', current_timestamp, 'admin', 'PC', 'Pick at Counter', 1, '000002'),
(3, current_timestamp, 'admin', current_timestamp, 'admin', 'TA', 'Take Away', 1, '000003'),
(4, current_timestamp, 'admin', current_timestamp, 'admin', 'RS', 'Room Service', 1, '000004')

INSERT into tb_tr_status (tr_status_id, created_on, created_by, modified_on, modified_by, tr_status_code, tr_status_desc, is_in_use, display_seq) VALUES
(1, current_timestamp, 'admin', current_timestamp, 'admin', 'C', 'Confirmed', 1, '000001'),
(2, current_timestamp, 'admin', current_timestamp, 'admin', 'X', 'Cancelled', 1, '000002')

-- Default user group 
INSERT INTO tb_user_group (user_group_id, created_on, created_by, modified_on, modified_by, user_group_desc, is_in_use, display_seq) VALUES
(1, current_timestamp, 'admin', current_timestamp, 'admin', 'Admin', 1, '000001'),
(2, current_timestamp, 'admin', current_timestamp, 'admin', 'Manager', 1, '000002'),
(3, current_timestamp, 'admin', current_timestamp, 'admin', 'Cashier', 1, '000003')