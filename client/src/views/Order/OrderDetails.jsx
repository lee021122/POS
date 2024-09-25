import React, { useState } from 'react';
import { Box, Typography, MenuItem, FormControl, Select } from "@mui/material";

const OrderDetails = ({ order_num }) => {
  const [table, setTable] = useState('Select Table');
  const [dineOption, setDineOption] = useState('Order Type');

  const handleTableChange = (e) => {
    setTable(e.target.value);
  };

  const handleDineOptionChange = (e) => {
    setDineOption(e.target.value);
  };

  return (
    <Box sx={{ 
        padding:2, 
        borderBottom: '1px solid #ccc', 
        backgroundColor: 'transparent', 
        margin: '10px',                  
    }}>
      <Typography variant="h4" fontWeight="bold" color="#33372C" gutterBottom 
       sx={{ textAlign: 'center' }}
      >
        Order Details
      </Typography>
      <Typography variant="body1" color="#7D7C7C" gutterBottom
       sx={{ textAlign: 'center' }}
      >
        Order Number: {order_num}
      </Typography>
      
      <Box sx={{ display: 'flex', gap:"5px" }}>
      <FormControl fullWidth  mx="30px"
      sx={{borderRadius: "24px", flex: 1 }}>
        <Select value={table} onChange={handleTableChange} 
        sx={{
        borderRadius: '24px', 
        backgroundColor: '#f5f5f5', 
        width: '100%',
        height: '35px',
        }}
        >
          <MenuItem value="Select Table" disabled>Select Table</MenuItem>
          <MenuItem value="Table 01">Table 01</MenuItem>
          <MenuItem value="Table 02">Table 02</MenuItem>
          <MenuItem value="Table 03">Table 03</MenuItem>
          <MenuItem value="Table 04">Table 04</MenuItem>
          <MenuItem value="Table 05">Table 05</MenuItem>
        </Select>
      </FormControl>

      <FormControl fullWidth mx="30px" sx={{ borderRadius: '24px', flex: 1 }}>
      <Select value={dineOption} onChange={handleDineOptionChange}
        sx={{
        borderRadius: '24px',
        backgroundColor: '#f5f5f5', 
        width: '100%',
        height: '35px',

        }}
        >
          <MenuItem value="Order Type" disabled>Order Type</MenuItem>
          <MenuItem value="Dine In">Dine In</MenuItem>
          <MenuItem value="Take Away">Take Away</MenuItem>
        </Select>
      </FormControl>
      </Box>
      
    </Box>
    

    
  );
};

export default OrderDetails;
