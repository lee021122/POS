CREATE OR REPLACE PROCEDURE pr_sys_send_email (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	OUT p_mail_id uuid,
	IN p_send_to text,
	IN p_cc_to text,
	IN p_bcc_to text,
	IN p_subject text,
	IN p_email_body text,
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
BEGIN
/*

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	p_mail_id := gen_random_uid();
	
	INSERT INTO tb_mail (
		mail_id, created_on, created_by, send_to, cc_to, subject, email_body, attach_file, mail_type_id, send_status, send_on
	) VALUES (
		p_mail_uid, v_now, p_current_uid, p_send_to, p_cc_to, p_bcc_to, p_subject, p_email_body, p_attach_file, 
	);
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;