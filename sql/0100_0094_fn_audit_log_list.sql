CREATE OR REPLACE FUNCTION fn_audit_log_list (
	p_current_uid character varying(255),
	p_start_dt date,
	p_end_dt date,
	p_rid integer,
	p_axn character varying(255),
	p_url character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	created_on text, 
	created_by character varying(255), 
	module_code character varying(255), 
	task text
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	module_code text;
	audit_log text;
BEGIN
/*
 	SELECT * FROM fn_audit_log_list('tester', null, null, null, null, null)
*/
	
	module_code := 'Audit Log';
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF p_start_dt IS NULL THEN
		p_start_dt := fn_get_past_7days();
	END IF;
	
	IF p_end_dt IS NULL THEN
		p_end_dt := fn_get_current_date();
	END IF;

	-- -------------------------------------
	-- process
	-- -------------------------------------
	RETURN QUERY (
		SELECT 
			a.created_on::text, a.created_by, a.module_code, a.task
		FROM tb_audit_log a
		WHERE 
			a.created_on BETWEEN p_start_dt AND p_end_dt
		ORDER BY 
			a.created_on, a.created_by, a.module_code
	);
	
	audit_log := 'Viewing Audit Log, Date Range ' || p_start_dt::TEXT || ' - ' || p_end_dt::TEXT || '.';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'fn_audit_log_list'
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

END
$$;