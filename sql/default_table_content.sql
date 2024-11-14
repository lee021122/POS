insert into tb_action (action_id, action_code, action_desc, sql_q, group_code, is_in_use, display_seq, created_on, created_by) values
-- Module: Product
(gen_random_uuid(), 'prod-category::s', 'Product - Category Save', 'pr_prod_category_save', 'Product', 1, '000001', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-category::l', 'Product - Category List', 'fn_prod_category_list', 'Product', 1, '000002',  current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-category::d', 'Product - Category Delete', 'pr_prod_category_delete', 'Product', 0, '000003', current_timestamp, 'admin'),

(gen_random_uuid(), 'prod-setup::s', 'Product - Save', 'pr_product_save', 'Product', 1, '000004', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-setup::l', 'Product - List', 'fn_product_list', 'Product', 1, '000005',  current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-setup::d', 'Product - Delete', 'pr_product_delete', 'Product', 0, '000006', current_timestamp, 'admin'),

(gen_random_uuid(), 'prod-modifier::gs', 'Product - Modifier Group Save', 'pr_product_modifier_group_save', 'Product', 1, '000007', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-modifier::gl', 'Product - Modifier Group List', 'fn_modifier_group_list', 'Product', 1, '000008', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-modifier::gos', 'Product - Modifier Group Option Save', 'pr_product_modifier_item_save', 'Product', 1, '000009', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-modifier::gol', 'Product - Modifier Group Option List', 'fn_product_modifier_item_list', 'Product', 1, '000010', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-modifier::lis', 'Product - Modifier Group Link Item Save', 'pr_product_modifier_group_item_link_save', 'Product', 1, '000011', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-modifier::lil', 'Product - Modifier Group Link Item List', 'fn_product_modifier_group_item_link_list', 'Product', 1, '000012', current_timestamp, 'admin'),

(gen_random_uuid(), 'prod-daily-avail::s', 'Product - Daily Availabilty Save', 'pr_daily_availability_update', 'Product', 1, '000013', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-daily-avail::l', 'Product - Daily Availabilty List', 'fn_daily_availability_list', 'Product', 1, '000014',  current_timestamp, 'admin'),

-- Module: Settings
(gen_random_uuid(), 'setting-general::s', 'Setting - General Setting Save', 'pr_general_setting_save', 'Setting', 1, '000015', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-general::l', 'Setting - General Setting List', 'fn_general_setting_list', 'Setting', 1, '000016', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-store::s', 'Setting - Store Save', 'pr_store_save', 'Setting', 1, '000017', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-store::l', 'Setting - Store List', 'fn_store_list', 'Setting', 1, '000018', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-store::d', 'Setting - Store Delete', 'pr_store_delete', 'Setting', 0, '000019', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-tax::s', 'Setting - Tax Save', 'pr_tax_save', 'Setting', 1, '000020', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-tax::l', 'Setting - Tax List', 'fn_tax_list', 'Setting', 1, '000021', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-tax::d', 'Setting - Tax Delete', 'pr_tax_delete', 'Setting', 0, '000022', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-pymt-mode::s', 'Setting - Payment Mode Save', 'pr_pymt_mode_save', 'Setting', 1, '000023', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-pymt-mode::l', 'Setting - Payment Mode List', 'fn_pymt_mode_list', 'Setting', 1, '000024', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-pymt-mode::d', 'Setting - Payment Mode Delete', 'pr_pymt_mode_delete', 'Setting', 0, '000025', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-pymt-mode::tl', 'Setting - Payment Type List', 'fn_pymt_type_list', 'Setting', 1, '000026', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-meal-period::s', 'Setting - Meal Period Save', 'pr_meal_period_save', 'Setting', 1, '000027', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-meal-period::l', 'Setting - Meal Period List', 'fn_meal_period_list', 'Setting', 1, '000028', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-meal-period::d', 'Setting - Meal Period Delete', 'pr_meal_period_delete', 'Setting', 0, '000029', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-receipt-temp::s', 'Setting - Receipt Template Save', 'pr_receipt_temp_save', 'Setting', 1, '000030', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-receipt-temp::l', 'Setting - Receipt Template List', 'fn_receipt_temp_list', 'Setting', 1, '000031', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-receipt-temp::d', 'Setting - Receipt Template Delete', 'pr_receipt_temp_delete', 'Setting', 0, '000032', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-table-sec::s', 'Setting - Table Section Save', 'pr_table_section_save', 'Setting', 1, '000033', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-table-sec::l', 'Setting - Table Section List', 'fn_table_section_list', 'Setting', 1, '000034', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-table-sec::d', 'Setting - Table Section Delete', 'pr_table_section_delete', 'Setting', 0, '000035', current_timestamp, 'admin'),

(gen_random_uuid(), 'setting-table::s', 'Setting - Table Save', 'pr_table_save', 'Setting', 1, '000036', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-table::l', 'Setting - Table List', 'fn_table_list', 'Setting', 1, '000037', current_timestamp, 'admin'),
(gen_random_uuid(), 'setting-table::d', 'Setting - Table Delete', 'pr_table_delete', 'Setting', 0, '000038', current_timestamp, 'admin'),

(gen_random_uuid(), 'pos-station::s', 'Setting - POS Station Save', 'pr_pos_station_save', 'Setting', 1, '000039', current_timestamp, 'admin'),
(gen_random_uuid(), 'pos-station::l', 'Setting - POS Station List', 'fn_pos_station_list', 'Setting', 1, '000040', current_timestamp, 'admin'),

(gen_random_uuid(), 'pos-printer::s', 'Setting - POS Printer Save', 'pr_pos_printer_delete', 'Setting', 1, '000041', current_timestamp, 'admin'),
(gen_random_uuid(), 'pos-printer::l', 'Setting - POS Printer List', 'fn_pos_printer_delete', 'Setting', 1, '000042', current_timestamp, 'admin'),
(gen_random_uuid(), 'pos-printer::ptl', 'Setting - POS Printer Type List', 'pr_printer_type_delete', 'Setting', 1, '000043', current_timestamp, 'admin'),

(gen_random_uuid(), 'other::cl', 'Other - Country List', 'fn_country_list', 'Others', 1, '000044', current_timestamp, 'admin'),
(gen_random_uuid(), 'other::sl', 'Other - State List', 'fn_state_list', 'Others', 1, '000045', current_timestamp, 'admin'),
(gen_random_uuid(), 'other::ptl', 'Other - Pricing Type List', 'fn_pricing_type_list', 'Others', 1, '000046', current_timestamp, 'admin'),

-- Module: Customer
(gen_random_uuid(), 'app-customer::s', 'Customer - Save', 'pr_guest_save', 'Customer', 1, '000047', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-customer::l', 'Customer - List', 'fn_guest_list', 'Customer', 1, '000048', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-customer::d', 'Customer - Delete', 'pr_guest_delete', 'Customer', 0, '000049', current_timestamp, 'admin'),

-- Module: Supplier
(gen_random_uuid(), 'app-supplier::s', 'Supplier - Save', 'pr_supplier_save', 'Supplier', 0, '000050', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-supplier::l', 'Supplier - List', 'fn_supplier_list', 'Supplier', 0, '000051', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-supplier::d', 'Supplier - Delete', 'pr_supplier_delete', 'Supplier', 0, '000052', current_timestamp, 'admin'),

-- Module: Users
(gen_random_uuid(), 'app-user-group::s', 'User Group - Save', 'pr_user_group_save', 'Users', 1, '000053', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-user-group::l', 'User Group - List', 'fn_user_group_list', 'Users', 1, '000054', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-user-group::acs', 'User Group Action - Save', 'pr_user_group_action_save', 'Users', 1, '000055', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-user-group::acl', 'User Group Action - List', 'fn_user_group_action_list', 'Users', 1, '000056', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-users::s', 'Users - Save', 'pr_user_save', 'Users', 1, '000057', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-users::l', 'Users - List', 'fn_user_list', 'Users', 1, '000058', current_timestamp, 'admin'),

-- Module: Action
(gen_random_uuid(), 'app-axn::l', 'Action - Action List', 'fn_action_list', 'Action', 1, '000059', current_timestamp, 'admin'),

-- Module: Order
(gen_random_uuid(), 'app-order-trans::s', 'Order - Order Transaction Save', 'pr_order_trans_save', 'Order Process', 1, '000060', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::ails', 'Order - Add Item Line/ Add Payment Save', 'pr_pos_add_trans_item_line', 'Order Process', 1, '000061', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::sa', 'Order - Set Addon', 'pr_pos_addon_trans_set', 'Order Process', 1, '000062', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::ra', 'Order - Remove Addon', 'pr_pos_add_trans_remove', 'Order Process', 1, '000063', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::id', 'Order - Item Discount', 'pr_pos_trans_item_disc', 'Order Process', 1, '000064', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::bd', 'Order - Bill Discount', 'pr_pos_trans_bill_disc', 'Order Process', 1, '000065', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::vi', 'Order - Void Item', 'pr_pos_trans_void_item', 'Order Process', 1, '000066', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::vb', 'Order - Void Bill', 'pr_pos_trans_void_bill', 'Order Process', 1, '000067', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::op', 'Order - Override Price', 'pr_pos_trans_override_price', 'Order Process', 1, '000068', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::sp', 'Order - Split Bill', 'pr_pos_trans_split_bill', 'Order Process', 1, '000069', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::pl', 'Order - Product List', 'fn_order_product_list', 'Order Process', 1, '000070', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-order-trans::ml', 'Order - Modifier List', 'fn_order_modifier_list', 'Order Process', 1, '000070', current_timestamp, 'admin'),

-- Module: Cashiering
(gen_random_uuid(), 'app-cashiering-shift::o', 'Cashiering - Cashiering Shift Open', 'pr_cashiering_start', 'Cashiering Shift', 1, '000070', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-cashiering-shift::c', 'Cashiering - Cashiering Shift Close', 'pr_cashiering_close', 'Cashiering Shift', 1, '000071', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-cashiering-shift::cp', 'Cashiering - Cashiering Shift Close Prepare Statement', 'pr_cashiering_prepare', 'Cashiering Shift', 1, '000072', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-cashiering-shift::sc', 'Cashiering - Current Cashiering Shift Show', 'pr_cashiering_current', 'Cashiering Shift', 1, '000073', current_timestamp, 'admin'),
(gen_random_uuid(), 'app-cashiering-shift::fc', 'Cashiering - Cashiering Shift Force Close', 'pr_cashiering_force_close', 'Cashiering Shift', 1, '000074', current_timestamp, 'admin'),

-- Module: Day-end Closing


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
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'category_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'category_desc', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'display_seq', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 8, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 10, 0, current_timestamp, 'admin'),
-- prod-category::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- prod-category::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'category_id', 'id', 3, 0, current_timestamp, 'admin'),

-- prod-setup::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'product_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'product_desc', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'product_code', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'category_id', 'id', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'product_tag', 'string', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'product_img_path', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'supplier_id', 'id', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'pricing_type_id', 'id', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'cost', 'money', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'sell_price', 'money', 12, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'tax_code1', 'string', 13, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'amt_include_tax1', 'int', 14, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'tax_code2', 'string', 15, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'amt_include_tax2', 'int', 16, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'calc_tax2_after_tax1', 'int', 17, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 18, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'display_seq', 'string', 19, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_enable_kitchen_printer', 'int', 20, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_allow_modifier', 'int', 21, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_enable_track_stock', 'int', 22, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_popular_item', 'int', 23, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'meal_period', 'text', 24, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 25, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 26, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 27, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 28, 0, current_timestamp, 'admin'),
-- prod-setup::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
--prod-setup::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'product_id', 'id', 3, 0, current_timestamp, 'admin'),

-- prod-modifier::gs
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_group_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_group_name', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_single_modifier_choice', 'int', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_multiple_modifier_choice', 'int', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 10, 0, current_timestamp, 'admin'),
-- prod-modifier::gl
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 5, 0, current_timestamp, 'admin'),
-- prod-modifier::gos
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_option_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_group_id', 'id', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_option_name', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'addon_amt', 'money', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_default', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 11, 0, current_timestamp, 'admin'),
-- prod-modifier::gol
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_group_id', 'id', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- prod-modifier::lis
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'link_item', 'text', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_group_id', 'id', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 8, 0, current_timestamp, 'admin'),
-- prod-modifier::lil
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'modifier_group_id', 'id', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
--prod-daily-avail::s

-- prod-daily-avail::l


-- setting-general::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'setting_title', 'text', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'setting_value', 'text', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 8, 0, current_timestamp, 'admin'),
-- setting-general::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 5, 0, current_timestamp, 'admin'),

-- setting-store::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'store_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'store_name', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'addr_line_1', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'addr_line_2', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'city', 'string', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'state', 'id', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'post_code', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'country', 'id', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'phone_number', 'string', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'email', 'string', 12, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'website', 'string', 13, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'gst_id', 'string', 14, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'sst_id', 'string', 15, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'business_registration_num', 'string', 16, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'receipt_temp_id', 'id', 17, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 18, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 19, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 20, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 21, 0, current_timestamp, 'admin'),
-- setting-store::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 5, 0, current_timestamp, 'admin'),
-- setting-store::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'store_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-tax::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'tax_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'tax_code', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'tax_desc', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'tax_pct', 'money', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'display_seq', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 12, 0, current_timestamp, 'admin'),
-- setting-tax::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- setting-tax::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'tax_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-pymt-mode::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'pymt_mode_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'pymt_mode_desc', 'string', 4, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'pymt_type', 'id', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 10, 0, current_timestamp, 'admin'),
-- setting-pymt-mode::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- setting-pymt-mode::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'pymt_mode_id', 'id', 3, 0, current_timestamp, 'admin'),


-- setting-meal-period::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'meal_period_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'meal_period_desc', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'start_time', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'end_time', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'display_seq', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- setting-meal-period::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- setting-meal-period::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'meal_period_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-receipt-temp::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'receipt_temp_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'receipt_temp_name', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'logo_img_path', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'extra_information', 'text', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_show_store_name', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_show_store_details', 'int', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_show_customer_details', 'int', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_show_customer_point', 'int', 10, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'integer', 11, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 12, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 13, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 14, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 15, 0, current_timestamp, 'admin'),
-- setting-receipt-temp::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- setting-receipt-temp::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'receipt_temp_id', 'id', 3, 0, current_timestamp, 'admin'),

-- setting-table-sec::s
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'table_section_id', 'id', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'table_section_name', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'display_seq', 'string', 6, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 7, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 8, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 9, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 10, 0, current_timestamp, 'admin'),
-- setting-table-sec::l
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_in_use', 'int', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'rid', 'int', 3, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'axn', 'string', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'url', 'string', 5, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'is_debug', 'int', 6, 0, current_timestamp, 'admin'),
-- setting-table-sec::d
(gen_random_uuid(), '', 'current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'msg', 'text', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), '', 'table_section_id', 'id', 3, 0, current_timestamp, 'admin'),

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

-- Save
-- app-order-trans::s 

-- Add Line Save
-- app-order-trans::ails

-- Bill Discount
-- app-order-trans::bd

-- Void Item
-- app-order-trans::vi

-- Void Bill
-- app-order-trans::vb



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

insert into tb_sys_setting (created_on, created_by, modified_on, modified_by, sys_setting_title, sys_setting_value, can_customize) values 
(current_timestamp, 'admin', current_timestamp, 'admin', 'CURRENT_TRANS_DATE', '2024-10-16', 1),
--(current_timestamp, 'admin', current_timestamp, 'admin', 'ORDER_NO_PREFIX', 'OR-'),
(current_timestamp, 'admin', current_timestamp, 'admin', 'ORDER_NO_LENGTH', '5', 0),
-- Pay-first or Pay-later
(current_timestamp, 'admin', current_timestamp, 'admin', 'OPERATION_MODE', '', 1),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_server', '', 1),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_port', '', 1),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_mailbox_id', '', 1),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_mailbox_pwd', '', 1),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_use_ssl', '', 1),
(current_timestamp, 'admin', current_timestamp, 'admin', 'smtp_able_service', '', 1),
-- Default (sell as much as) or set daily availability
(current_timestamp, 'admin', current_timestamp, 'admin', 'QR_ORDER_AVAILABILITY', '', 1),
(current_timestamp, 'admin', current_timestamp, 'admin', 'POS_URL', '', 0),
(current_timestamp, 'admin', current_timestamp, 'admin', 'POS_ADMIN_PORTAL_URL', '', 0),
(current_timestamp, 'admin', current_timestamp, 'admin', 'POS_QR_ORDER_URL', '', 0)


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
(-999, current_timestamp, 'admin', current_timestamp, 'admin', 'All', 1, '000004')