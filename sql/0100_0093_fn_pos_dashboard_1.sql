CREATE OR REPLACE FUNCTION fn_pos_dashboard_1 (
	IN p_current_uid character varying(255),
	IN p_rid integer,
	IN p_axn character varying(255),
	IN p_url character varying(255),
	IN p_is_debug integer DEFAULT 0
) RETURNS TABLE (
	total_sales numeric(15, 2),
	total_order integer,
	avg_sales numeric(15, 2),
	total_discount numeric(15, 2)
)
LANGUAGE 'plpgsql'
AS $$
-- -------------------------------------
-- init
-- -------------------------------------
DECLARE
	v_tr_dt date;
BEGIN
/* -- Dashboard Default Card
	
*/

	-- -------------------------------------
    -- validation
    -- -------------------------------------
	v_tr_dt := fn_get_current_trans_dt();

    -- -------------------------------------
    -- process
    -- -------------------------------------	
	RETURN QUERY (
		SELECT 
			ROUND(SUM(a.amt), 2) AS total_sales, 
			COUNT(a.*) AS total_order, 
			ROUND(AVG(a.amt), 2) AS avg_sales, 
			ROUND(SUM(a.total_disc), 2) AS total_discount
		FROM tb_order_trans a
-- 		LEFT JOIN tb_order_trans_item_line 
		WHERE 
			a.tr_date = v_tr_dt
			AND a.tr_status = 'C'
	);
	
	-- -------------------------------------
    -- cleanup
    -- -------------------------------------

END
$$;