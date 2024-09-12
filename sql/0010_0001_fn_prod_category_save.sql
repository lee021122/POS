-- FUNCTION: public.fn_prod_category_save(character varying, uuid, character varying, integer, character varying, integer)

-- DROP FUNCTION IF EXISTS public.fn_prod_category_save(character varying, uuid, character varying, integer, character varying, integer);

CREATE OR REPLACE FUNCTION public.fn_prod_category_save(
	p_current_uid character varying,
	p_category_id uuid,
	p_category_desc character varying,
	p_is_in_use integer,
	p_display_seq character varying,
	p_is_debug integer DEFAULT 0)
    RETURNS TABLE(msg text, output_category_id uuid) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_now CONSTANT timestamp = localtimestamp;
	v_msg text;
	audit_log text;
	v_newid CONSTANT uuid = gen_random_uuid();
    v_category_id_old uuid;
	v_category_desc_old character varying;
	v_is_in_use_old integer;
	v_display_seq_old character varying;
BEGIN
/**
0010_0001_fn_prod_category_save

-- Save Product Category

select * 
from fn_prod_category_save (
	p_current_uid => 'tester',
	p_category_id => '1412a87d-ec29-4ed7-8799-9e669a1969f2',
	p_category_desc => 'Drinks',
	p_is_in_use => 1,
	p_display_seq => '000001'
);

*/

    IF p_is_debug = 1 THEN
		RAISE NOTICE 'fn_category_save - start';
	END IF;
	
	-- -------------------------------------
	-- validation
	-- -------------------------------------
	IF EXISTS (
		SELECT *
		FROM tb_prod_category 
		WHERE 
			category_desc = p_category_desc
			AND category_id <> fn_to_guid(p_category_id)
	) THEN
		RETURN QUERY (
			SELECT 'Category Code: ' || p_category_desc || ' already exists!!'msg, null AS category_id
		);
		RETURN;
	END IF;
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF fn_to_guid(p_category_id) = fn_empty_guid() THEN
	
		-- insert new record
		INSERT INTO tb_prod_category (
			category_id, created_on, created_by, modified_on, modified_by, category_desc, is_in_use, display_seq
		) 
		VALUES
		(v_newid, v_now, lower(p_current_uid), v_now, lower(p_current_uid), p_category_desc, p_is_in_use, p_display_seq);
		
		
		v_msg = 'ok';
	
		-- -------------------------------------
		-- return message
		-- -------------------------------------
		RETURN QUERY(
			SELECT 
				v_msg AS msg, 
				v_newid AS output_category_id
		);
		RETURN;
			
	ELSE
		
		-- Get old record for update purpose
		SELECT category_desc, is_in_use, display_seq
        INTO v_category_desc_old, v_is_in_use_old, v_display_seq_old
        FROM tb_prod_category
        WHERE category_id = p_category_id;

		-- Update Record
		UPDATE tb_prod_category
		SET 
			category_desc = p_category_desc, 
			is_in_use = p_is_in_use,
			display_seq = p_display_seq,
			modified_on = v_now,
			modified_by = lower(p_current_uid)
		WHERE category_id = p_category_id;
		
		v_msg = 'ok';
	
		-- -------------------------------------
		-- return message
		-- -------------------------------------
		RETURN QUERY(
			SELECT 
				v_msg AS msg, 
				p_category_id AS output_category_id
		);
		RETURN;
	
	END IF;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------
	
	IF p_is_debug = 1 THEN
		RAISE NOTICE 'fn_category_save - end';
	END IF;

END;
$BODY$;

ALTER FUNCTION public.fn_prod_category_save(character varying, uuid, character varying, integer, character varying, integer)
    OWNER TO leehao;
