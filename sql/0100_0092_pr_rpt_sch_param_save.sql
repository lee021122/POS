CREATE OR REPLACE PROCEDURE pr_rpt_sch_param_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	INOUT p_rpt_sch_param_id uuid,
	IN p_rpt_sch_id uuid,
	IN p_rpt_param text,
	IN p_rpt_param_value text,
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
	module_code text;
	audit_log text;
	v_rpt_sch_id_old uuid;
	v_rpt_param_old text;
	v_rpt_param_value_old text;
BEGIN
/*

*/

	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_rpt_sch_param_save - start';
	END IF;
	
	module_code := 'Scheduler Report';

	-- -------------------------------------
	-- valiadation
	-- -------------------------------------
	IF NOT EXISTS (
		SELECT rpt_sch_id
		FROM tb_rpt_sch
		WHERE rpt_sch_id = p_rpt_sch_id
	) THEN 
		p_msg := 'Invalid Scheduler Report!!';
		RETURN;
	END IF;

	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF fn_to_guid(p_rpt_sch_param_id) = fn_empty_guid() THEN
	
		p_rpt_sch_param_id := gen_random_uuid();
		
		INSERT INTO tb_rpt_sch_param (
			rpt_sch_param_id, created_on, created_by, modified_on, modified_by, rpt_sch_id, rpt_param, rpt_param_value
		) VALUES (
			p_rpt_sch_param_id, v_now, p_current_uid, v_now, p_current_uid, p_rpt_sch_id, p_rpt_param, p_rpt_param_value
		);
		
		audit_log := 'Added new params to Report: ' || fn_get_desc_from_id('tb_rpt_sch', p_rpt_sch_id) || ',  Params: ' || p_rpt_params || ', Params Value: ' || p_rpt_param_value || '.';
		
	ELSE
		
		-- Get old record foro audiit log purpose 
		SELECT rpt_sch_id, rpt_param, rpt_param_value
		INTO v_rpt_sch_id_old, v_rpt_param_old, v_rpt_param_value_old
		FROM tb_rpt_sch_param
		WHERE rpt_sch_param_id = p_rpt_sch_param_id;
		
		-- Update Record
		UPDATE tb_rpt_sch_param
		SET 
			modified_on = v_now,
			modified_by = p_current_uid,
			rpt_sch_id = p_rpt_sch_id, 
			rpt_param = p_rpt_param, 
			rpt_param_value = p_rpt_param_value
		WHERE rpt_sch_param_id = p_rpt_sch_param_id;
		
		audit_log := 'Updated Report from ' || fn_get_desc_from_id('tb_rpt_sch', v_rpt_sch_id_old) || ' to ' || fn_get_desc_from_id('tb_rpt_sch', p_rpt_sch_id) || ', ' ||
						'Updated Parmas from ' || v_rpt_param_old || ' to ' || p_rpt_params || ', ' ||
						'Updated Parmas Value from ' || v_rpt_param_value_old || ' to ' || p_rpt_param_value || '.';
	
	END IF;
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_rpt_sch_param_save'
		, p_uid => p_current_uid
		, p_id1 => p_rpt_sch_param_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	); 

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_rpt_sch_param_save - end';
	END IF;

END
$BODY$;