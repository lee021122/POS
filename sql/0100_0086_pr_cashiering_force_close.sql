CREATE OR REPLACE PROCEDURE pr_cashiering_force_close (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	IN p_curr_tr_dt date,
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
	v_now CONSTANT timestamp = current_timestamp;
	audit_log text;
	module_code text;
	cashier_id_r text;
BEGIN
/* 0100_0086_pr_cashiering_force_close

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_cashiering_force_close - start';
	END IF;
	
	module_code := 'Cashiering - Force Close Shift';

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF p_curr_tr_dt IS NULL THEN 
		p_curr_tr_dt := fn_get_current_trans_dt();
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	FOR cashier_id_r IN
		SELECT cashier_id
		FROM tb_cashiering
		WHERE 
			tr_date = p_curr_tr_dt
			AND end_on IS NULL
		
		LOOP

			-- Only add a comma if 's' is not empty
			IF cashier_id_r = '' THEN
				cashier_id_r := cashier_id_r;
			ELSE
				cashier_id_r := csh || ', ' || cashier_id_r;
			END IF;
			
	END LOOP;
	
	UPDATE tb_cashiering 
	SET 
		force_close_on = v_now,
		force_close_by = p_current_uid,
		
		end_on = v_now,
		remarks = 'Force Close by Night Auditor.'
	WHERE 
		tr_date = p_curr_tr_dt
		AND end_on IS NULL;
		
	audit_log := 'Force the closure of the cashiering shift for the specified cashier ID: ' || COALESCE(cashier_id_r, '') || '.';
		
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_cashiering_force_close'
		, p_uid => p_current_uid
		, p_id1 => null
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	); 
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_cashiering_force_close - end';
	END IF;

END
$BODY$;