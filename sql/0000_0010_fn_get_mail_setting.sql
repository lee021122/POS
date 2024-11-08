CREATE OR REPLACE FUNCTION fn_get_mail_setting (
	store_id uuid,
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	smtp_server text,
	smtp_port text,
	smtp_mailbox_id text,
	smtp_mailbox_pwd text,
	smtp_use_ssl text,
	smtp_able_service text
) 
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
ROWS 1000
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_smtp_server text;
	v_smtp_port integer;
	v_smtp_mailbox_id text;
	v_smtp_mailbox_pwd text;
	v_smtp_use_ssl integer;
	v_smtp_able_service integer;
BEGIN
/* 0000_0010_fn_get_mail_setting

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'fn_get_mail_setting - start';
	END IF;

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	
	-- SMTP_SERVER
	SELECT sys_setting_value
	INTO v_smtp_server
	FROM tb_sys_setting
	WHERE sys_setting_title = 'smtp_server';
	
	-- SMTP_SERVER
	SELECT sys_setting_value::integer
	INTO v_smtp_port
	FROM tb_sys_setting
	WHERE sys_setting_title = 'smtp_port';
	
	-- SMTP_SERVER
	SELECT sys_setting_value
	INTO v_smtp_mailbox_id
	FROM tb_sys_setting
	WHERE sys_setting_title = 'smtp_mailbox_id';
	
	-- SMTP_SERVER
	SELECT sys_setting_value
	INTO v_smtp_mailbox_pwd
	FROM tb_sys_setting
	WHERE sys_setting_title = 'smtp_mailbox_pwd';
	
	-- SMTP_SERVER
	SELECT sys_setting_value::integer
	INTO v_smtp_use_ssl
	FROM tb_sys_setting
	WHERE sys_setting_title = 'smtp_use_ssl';
	
	-- SMTP_SERVER
	SELECT sys_setting_value::integer
	INTO v_smtp_able_service
	FROM tb_sys_setting
	WHERE sys_setting_title = 'smtp_able_service';
	
	SELECT
		v_smtp_server,
		v_smtp_port,
		v_smtp_mailbox_id,
		v_smtp_mailbox_pwd,
		v_smtp_use_ssl,
		v_smtp_able_service;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'fn_get_mail_setting - end';
	END IF;

END
$$;