insert into tb_action (action_id, action_code, action_desc, sql_q, group_code, is_in_use, display_seq, created_on, created_by) values
(gen_random_uuid(), 'prod-category::s', 'Product Category - Save', 'fn_prod_category_save', null, 1, '000001', current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-category::l', 'Product Category - List', 'fn_prod_category_list', null, 1, '000002',  current_timestamp, 'admin'),
(gen_random_uuid(), 'prod-category::d', 'Product Category - Delete', 'fn_prod_category_delete', null, 1, '000003', current_timestamp, 'admin')

insert into tb_action_param (action_param_id, action_id, action_param_name, data_type, seq, is_compulsory, created_on, created_by) values
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'p_current_uid', 'string', 1, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'p_category_id', 'id', 2, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'p_category_desc', 'string', 3, 1, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'p_is_in_use', 'int', 4, 0, current_timestamp, 'admin'),
(gen_random_uuid(), 'fe71c456-d38f-4b0f-9ac1-ba24c2280d17', 'p_display_seq', 'string', 5, 0, current_timestamp, 'admin')

insert into tb_pricing_type (pricing_type_id, created_on, created_by, modified_on, modified_by, pricing_type_desc, is_in_use) values
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Fixed', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'Variable', 1),
(gen_random_uuid(), current_timestamp, 'admin', current_timestamp, 'admin', 'By Unit', 1)

