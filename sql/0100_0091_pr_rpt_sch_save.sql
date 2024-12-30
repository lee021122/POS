CREATE OR REPLACE PROCEDURE pr_rpt_sch_save (
	IN p_current_uid character varying(255),
	OUT p_msg text,
	INOUT p_rpt_sch_id uuid,
	IN p_rpt_sch_desc character varying(255),
	IN p_rpt_tmpl_id uuid,
	IN p_repeat_type_id uuid,
	IN p_send_on character varying(50),
	IN p_send_to text,
	IN p_is_in_use integer,
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
	p_repeat_on character varying(50);
	v_rpt_sch_desc_old character varying(255);
	v_rpt_tmpl_id_old uuid;
	v_repeat_type_id_old uuid;
	v_send_on_old character varying(50);
	v_send_to_old text;
	v_repeat_on_old character varying(50);
	v_is_in_use_old integer;
BEGIN
/*

*/
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_rpt_sch_save - start';
	END IF;
	
	module_code := 'Scheduler Report';

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF LENGTH(COALESCE(p_rpt_sch_desc, '')) = 0 THEN
		p_msg := 'Scheduler Report Description cannot be blank!!';
		RETURN;
	END IF;
	
	IF fn_to_guid(p_rpt_tmpl_id) = fn_empty_guid THEN 
		p_msg := 'Must Select a Report to send!!';
		RETURN;
	END IF;
	
	IF NOT EXISTS (
		SELECT rpt_tmpl_id
		FROM tb_rpt_tmpl
		WHERE rpt_tmpl_id = p_rpt_tmpl_id
	) THEN
		p_msg := 'Invalid Report Template!!';
		RETURN;
	END IF;
	
	IF NOT EXISTS (
		SELECT repeat_type_id
		FROM tb_repeat_type
		WHERE repeat_type_id = p_repeat_type_id
	) THEN
		p_msg := 'Invalid Repeat Type!!';
		RETURN;
	END IF; 
	
	IF LENGTH(COALESCE(p_send_on, '')) = 0 THEN
		p_msg := 'Send on cannot be blank!!';
		RETURN;
	END IF;
	
	IF LENGTH(COALESCE(p_send_to, '')) = 0 THEN
		p_msg := 'Send to cannot be blank!!';
		RETURN;
	END IF;
	
	SELECT repeat_type_value
	INTO p_repeat_on
	FROM tb_repeat_type
	WHERE repeat_type_id = p_repeat_type_id;
	
	--p_repeat_on := ''
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF fn_to_guid(p_rpt_sch_id) = fn_empty_guid() THEN
		
		p_rpt_sch_id := gen_random_uuid();
		
		INSERT INTO tb_rpt_sch (
			rpt_sch_id, created_on, created_by, modified_on, modified_by, rpt_sch_desc, rpt_tmpl_id, repeat_type_id, send_on, send_to, repeat_on, is_in_use
		) VALUES (
			p_rpt_sch_id, v_now, p_current_uid, v_now, p_current_uid, p_rpt_sch_desc, p_rpt_tmpl_id, p_repeat_type_id, p_send_on, p_send_to, p_repeat_on, COALESCE(p_is_in_use, 0)
		);
		
		audit_log := 'Added new scheduler report ' || p_rpt_sch_desc || ' successfully.';
		
	ELSE
		
		-- Get old record foro audiit log purpose 
		SELECT rpt_sch_desc, rpt_tmpl_id, repeat_type_id, send_on, send_to, repeat_on, is_in_use
		INTO v_rpt_sch_desc_old, v_rpt_tmpl_id_old, v_repeat_type_id_old, v_send_on_old, v_send_to_old, v_repeat_on_old, v_is_in_use_old
		FROM tb_rpt_sch
		WHERE rpt_sch_id = p_rpt_sch_id;
		
		-- Update Record
		UPDATE tb_rpt_sch
		SET 
			modified_on = v_now,
			modified_by = p_current_uid,
			rpt_sch_desc = p_rpt_sch_desc,
			rpt_tmpl_id = p_rpt_tmpl_id, 
			repeat_type_id = p_repeat_type_id, 
			send_on = p_send_on, 
			send_to = p_send_to, 
			repeat_on = p_repeat_on, 
			is_in_use = COALESCE(p_is_in_use, 0)
		WHERE rpt_sch_id = p_rpt_sch_id;
		
		audit_log := 'Updated Scheduler Report Description from ' || v_rpt_sch_desc_old || ' to ' || p_rpt_sch_desc || ', ' ||
						'Updated Scheduler Report Format from ' || fn_get_desc_from_id('tb_rpt_tmpl', v_rpt_tmpl_id_old) || ' to ' || fn_get_desc_from_id('tb_rpt_tmpl', p_rpt_tmpl_id) || ', ' ||
						'Updated Scheduler Report Repeat Type from ' || fn_get_desc_from_id('tb_repeat_type', v_repeat_type_id_old) || ' to ' || fn_get_desc_from_id('tb_repeat_type', p_repeat_type_id) || ', ' ||
						'Updated Send on from ' || v_send_on_old || ' to ' || p_rpt_sch_desc || ', ' ||
						'Updated Send to from ' || v_send_to_old || ' to ' || p_rpt_sch_desc || ', ' ||
						'Updated Repeat on from ' || v_repeat_on_old || ' to ' || p_rpt_sch_desc || ', ' ||
						'Updated Is In Use from ' || fn_yes_no_format(v_is_in_use_old) || ' to ' || fn_yes_no_format(p_rpt_sch_desc) || '.';
	
	END IF;
	
	p_msg := 'ok';
	
	-- Create Audit Log
	CALL pr_sys_append_audit_log (
		p_msg => audit_log
		, p_remarks => 'pr_rpt_sch_save'
		, p_uid => p_current_uid
		, p_id1 => p_rpt_sch_id
		, p_id2 => null
		, p_id3 => null
        , p_app_id => null
		, p_module_code => module_code
	); 
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'pr_rpt_sch_save - end';
	END IF;

END
$BODY$;