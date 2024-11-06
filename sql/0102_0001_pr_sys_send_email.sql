CREATE OR REPLACE PROCEDURE pr_sys_send_email (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	OUT p_mail_id uuid,
	IN p_send_to text,
	IN p_cc_to text,
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

BEGIN
/*

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	INSERT INTO 
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;