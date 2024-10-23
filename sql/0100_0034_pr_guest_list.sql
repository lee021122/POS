CREATE OR REPLACE FUNCTION fn_guest_list (
	p_current_uid character varying(255),
	p_axn character varying(255),
	p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	guest_id uuid, 
	modified_on timestamp, 
	modified_by character varying(255), 
	first_name character varying(255), 
	last_name character varying(255), 
	full_name character varying(255), 
	title character varying(50), 
	gender character varying(50), 
	phone_number character varying(50), 
	email character varying(255), 
	dob date,
	addr_line_1 character varying(255), 
	addr_line_2 character varying(255), 
	city character varying(255), 
	state uuid, 
	post_code character varying(255), 
	country uuid, 
	guest_tag character varying(255)
)
LANGUAGE 'plpgsql'
AS $BODY$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE

BEGIN
/* 0100_0034_fn_guest_list
	
	select * from fn_guest_list('tester', 'setting');
*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------

	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF p_axn = 'setting' THEN
	
		RETURN QUERY(
			SELECT 
				a.guest_id, a.modified_on, a.modified_by, a.first_name, a.last_name, a.full_name, a.title, a.gender, a.phone_number, a.email, a.dob,
				a.addr_line_1, a.addr_line_2, a.city, a.state, a.post_code, a.country, a.guest_tag
			FROM tb_guest a
			ORDER BY 
				a.guest_tag, a.full_name
		);
	
	ELSE
	
		RETURN QUERY(
			SELECT 
				a.guest_id, null AS modified_on, null AS modified_by, null AS first_name, null AS last_name, a.full_name, a.title, null AS gender, null AS phone_number, 
				null AS email, null AS dob, null AS addr_line_1, null AS addr_line_2, null AS city, null AS state, null AS post_code, null AS country, a.guest_tag
			FROM tb_guest a
			ORDER BY 
				a.guest_tag, a.full_name
		);
	
	END IF;

	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$BODY$;
