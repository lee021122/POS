CREATE OR REPLACE PROCEDURE pr_mail_sent_prepare (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	OUT p_mail_id uuid,
	IN p_mail_type_id integer,
	IN p_to text,
	IN p_cc text,
	IN p_bcc text,
	IN p_subject text,
	IN p_body text,
	IN p_attach_file text,
	IN p_is_debug integer DEFAULT 0
) 
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_now CONSTANT timestamp = current_timestamp;
	module_code text;
	audit_log text;
BEGIN
/* 0100_0078_pr_mail_sent_prepare

	CALL pr_mail_sent_prepare (
	
	);

*/
	
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_mail_sent_prepare - start';
	END IF;
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	p_mail_id := gen_random_uuid();
	
	INSERT INTO tb_mail (
		mail_id, created_on, created_by, sent_to, cc_to, bcc_to, subject, emai_body, attach_file, mail_type_id, send_status, send_on
	) VALUES (
		p_mail_id, v_now, p_current_uid, p_to, p_cc_to, p_bcc_to, p_subject, p_body, p_attach_file, p_mail_type_id, 0, null
	);
	
	audit_log := 'Prepare Email - ' ||
					'Email Subject: ' || p_subject || ', ' ||
					'Email Body: ' || p_body || ', ' ||
					'Sent to: ' || p_to || ', ' ||
					'CC to: ' || p_cc_to || ', ' ||
					'Bcc to: ' || p_bcc_to || '.';
					
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_mail_sent_prepare'
		, p_uid => p_current_uid
		, p_id1 => p_mail_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	);
					
	 
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_mail_sent_prepare - end';
	END IF;

END
$BODY$;