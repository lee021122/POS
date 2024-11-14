CREATE OR REPLACE PROCEDURE pr_cashiering_prepare (
	IN p_current_uid character varying(255),
	IN p_tr_date date,
	IN p_user_ip character varying(50), 			-- nodejs get the IP address
	IN p_rid integer,
	IN p_axn character varying(255),
	IN p_url character varying(255),
	IN p_is_debug integer DEFAULT 0
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/* 0100_0063_pr_cashiering_prepare

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;