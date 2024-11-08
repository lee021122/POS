CREATE OR REPLACE PROCEDURE pr_pos_trans_void_bill (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_order_trans_id uuid,
	IN p_override_by character varying(255),
	IN p_undo integer,
	IN p_is_debug integer DEFAULT 0
) 
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE

BEGIN 

END
$BODY$;