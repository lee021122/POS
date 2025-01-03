CREATE OR REPLACE FUNCTION fn_str_to_table (
	p_params text
) RETURNS TABLE (
	col text
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	s text;
	delimeter character varying(1);
	i integer;
	max_len integer;
BEGIN
/*

	-- Call the function with a string of comma-separated values
	SELECT * FROM fn_str_to_table('1,2,3,4,5');

	-- Another example with strings
	SELECT * FROM fn_str_to_table('aa,bb,cc,dd');

*/

	-- -------------------------------------
	-- validation
	-- -------------------------------------
	delimeter := ',';
	p_params := REPLACE(p_params, ', ', ',');
	max_len := LENGTH(COALESCE(p_params, ''));
	
	-- -------------------------------------
	-- process
	-- -------------------------------------
	IF max_len > 0 THEN
        -- Loop to extract values separated by the delimiter
        WHILE max_len > 0 LOOP
            -- Find the position of the delimiter
            i := POSITION(delimeter IN p_params);

            IF i > 0 THEN
                -- Extract the substring up to the delimiter
                s := TRIM(BOTH FROM SUBSTRING(p_params FROM 1 FOR i - 1));
                -- Update the parameter to remove the processed substring
                p_params := TRIM(BOTH FROM SUBSTRING(p_params FROM i + 1));
            ELSE
                -- No delimiter found, take the remaining string
                s := p_params;
                p_params := '';
            END IF;

            -- Insert the value into the result set
            IF LENGTH(s) > 0 THEN
                RETURN QUERY SELECT s;
            END IF;

            -- Update the length of remaining parameter
            max_len := LENGTH(p_params);
        END LOOP;
    END IF;

    RETURN;
	
	-- -------------------------------------
	-- cleanup
	-- -------------------------------------

END
$$;