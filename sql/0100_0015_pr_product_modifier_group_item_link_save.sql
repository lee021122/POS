CREATE OR REPLACE PROCEDURE pr_product_modifier_group_item_link_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	INOUT p_modifier_option_id uuid,
	IN p_modifier_group_id uuid,
	IN p_modifier_option_name character varying(255),
	IN p_addon_amt money,
	IN p_is_default integer,
	IN p_is_debug integer DEFAULT 0
)
language 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN

END
$BODY$;