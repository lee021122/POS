CREATE OR REPLACE FUNCTION fn_get_pos_url (
	p_current_uid character varying(255),
	p_axn character varying(255)
) RETURNS TEXT 
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	pos_url text;
BEGIN
/*

*/

    -- -------------------------------------
    -- validation
    -- -------------------------------------

    -- -------------------------------------
    -- process
    -- -------------------------------------
    IF p_axn = 'qr' THEN
 
        SELECT sys_setting_title 
		INTO pos_url 
        FROM tb_sys_setting 
        WHERE sys_Setting_title = 'POS_QR_ORDER_URL'
        LIMIT 1; 
        
    ELSIF p_axn = 'admin' THEN
        
        SELECT sys_setting_title 
		INTO pos_url 
        FROM tb_sys_setting 
        WHERE sys_Setting_title = 'POS_ADMIN_PORTAL_URL'
        LIMIT 1;
        
    ELSE
        -- Default case: Get the default POS URL
        SELECT sys_setting_title 
		INTO pos_url 
        FROM tb_sys_setting 
        WHERE sys_Setting_title = 'POS_URL'
        LIMIT 1;
        
    END IF;

    -- Return the result
    RETURN pos_url;
    
    -- -------------------------------------
    -- cleanup
    -- -------------------------------------

END
$BODY$;