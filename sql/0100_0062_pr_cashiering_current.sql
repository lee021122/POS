CREATE OR REPLACE PROCEDURE pr_cashiering_current (
	IN p_current_uid character varying(255),
	IN p_cashier_id character varying(255),
	IN p_tr_date date,
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
	v_curr_shift timestamp;
	v_last_shift timestamp;
BEGIN
/* 0100_0062_pr_cashiering_current

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_cashiering_current - start';
	END IF;

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF p_cashier_id IS NULL THEN 
		p_cashier_id := p_current_uid;
	END IF;
	
	IF p_tr_date IS NULL THEN 
		p_tr_date := fn_get_current_trans_dt();
	END IF;

	-- -------------------------------------
	-- process
	-- -------------------------------------
	SELECT start_on
	INTO v_curr_shift
	FROM tb_cashiering
	WHERE
		tr_date = p_tr_date
		AND cashier_id = p_cashier_id
		AND start_on IS NOT NULL
		AND end_on IS NULL;
		
	SELECT end_on
	INTO v_last_shift
	FROM tb_cashiering
	WHERE
		tr_date <= p_tr_date
		AND cashier_id = p_cashier_id
		AND end_on IS NOT NULL
	ORDER BY end_on DESC
	LIMIT 1;
	
	-- Return result
	SELECT 
		v_curr_shift AS current_shift,
		v_last_shift AS last_shift,
		p_cashier_id AS cashier_id,
		p_tr_date AS tr_date;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_cashiering_current - end';
	END IF;

END
$BODY$;