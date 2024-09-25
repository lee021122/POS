import { Box, Typography, IconButton } from "@mui/material";
import AddIcon from '@mui/icons-material/Add';
import RemoveIcon from '@mui/icons-material/Remove';
import { useState } from 'react';

const MenuOrdered = ({ id, title, price, quantity, onRemoveItem, updateQuantity }) => {
    const handleAdd = () => {
        updateQuantity(id, quantity + 1);
    };

    const handleRemove = () => {
        if (quantity > 1) {
        updateQuantity(id, quantity - 1);
        } else {
        onRemoveItem(id); // Call the function to remove the item if quantity is 0
        }
    };

    const totalPrice = price * quantity;


    return (
        <Box 
        mx="12px"
        my="4px"
        borderRadius="10px"
        sx={{
            backgroundColor: "#F5F5F5",
            boxShadow:"0px 2px 5px rgba(0, 0, 0, 0.20)"
        }}
        >
        <Box
            mx="20px"
            my="10px"
            display="flex"
            alignItems="center"
            justifyContent="space-between"
        >
            <Box ml="10px">
            <Typography variant="h6" color="#33372C">
                {title}
            </Typography>
            <Typography variant="subtitle2" color="grey">
                RM{totalPrice.toFixed(2)}
            </Typography>
            </Box>

            <Box display="flex" alignItems="center">
            <IconButton 
                size="small"
                onClick={handleRemove}
                sx={{width:"20px", height:"20px", border: "1px solid #ccc", borderRadius: "25px"}} 
            >
                <RemoveIcon fontSize="small" />
            </IconButton>

            <Typography variant="h6" mx="15px">
                {quantity}
            </Typography>

            <IconButton 
                size="small"
                onClick={handleAdd}
                sx={{width:"20px", height:"20px", border: "1px solid #ccc", borderRadius: "25px"}} 
            >
                <AddIcon fontSize="small" />
            </IconButton>
            </Box>
        </Box>
        
        </Box>
    );
};

export default MenuOrdered;
  
