CREATE OR REPLACE FUNCTION fn_get_desc_from_id (
	p_tb text,
	p_id uuid
) RETURNS TEXT
LANGUAGE 'plpgsql'
AS $$
DECLARE
	v_table_schema text;
	v_table_name text;
	v_column_name text;
	v_result text;
	v_primary_key text;
BEGIN
/*
	SELECT * FROM fn_get_desc_from_id('tb_meal_period', '77e1b5fb-c40b-4e0c-8638-7b807589fa37')
*/

	SELECT table_schema, table_name
	INTO v_table_schema, v_table_name
	FROM information_schema.tables
	WHERE 
		table_schema = 'public'
		AND table_name = p_tb;
		
	SELECT column_name
	INTO v_column_name
	FROM information_schema.columns
	WHERE 
		table_schema = 'public'
		AND table_name = p_tb
		AND (
			column_name like '%name%'  
		 	OR column_name like '%desc%'
		)
	LIMIT 1;
	
	SELECT kcu.column_name
	INTO v_primary_key
	FROM information_schema.table_constraints tc
	JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
	WHERE 
		tc.table_schema = 'public'  -- Adjust schema as needed
		AND tc.table_name = p_tb  -- Replace with your table name
		AND tc.constraint_type = 'PRIMARY KEY';


	
	-- Construct dynamic SQL to fetch the desired value
    EXECUTE format(
        'SELECT %I FROM %I WHERE %I = $1 LIMIT 1',
        v_column_name, v_table_name, v_primary_key
    )
    INTO v_result
    USING p_id;

    RETURN v_result;

END
$$;