/* eslint-disable react/prop-types */
import { Box, Typography, useTheme, Button, IconButton } from "@mui/material";
import { useState } from "react";
import { tokens } from "../../theme";
import{ RemoveCircleOutlineRounded, AddCircleOutlineRounded } from '@mui/icons-material';

const MenuPic = ({ title, image, price, category }) => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  
  // State to manage the quantity
  const [quantity, setQuantity] = useState(0);

  // Function to handle incrementing the quantity
  const handleAdd = () => {
    setQuantity(prevQuantity => prevQuantity + 1);
  };

  // Function to handle decrementing the quantity
  const handleRemove = () => {
    if (quantity > 0) {
      setQuantity(prevQuantity => prevQuantity - 1);
    }
  };

  return (
    <Box width="100%" 
      
    >
      <Box display="flex" flexDirection="column" alignItems="center">
        {image}
        <Typography variant="h6" fontWeight="bold" color={"#557C56"} mt="20px" align="center">
          {title}
        </Typography>
        <Typography variant="h6" color={colors.gray[100]}>
          {price}
        </Typography>
        
        {/* Conditionally render Add to Dish button or the counter based on the quantity */}
        {quantity === 0 ? (
          <Button
            variant="contained"
            onClick={handleAdd}
            sx={{ backgroundColor: "#CD5C08", fontWeight: "bold", width: "170px", mt: "10px", borderRadius: "24px",
              '&:hover': {
              backgroundColor: "#FFE7D1",
              color: "#CD5C08", // Change to your desired hover color
            }
              }}
            >
            Add to Dish
          </Button>
        ) : (
          <Box  display="flex" alignItems="center" justifyContent="space-between"
          sx={{
            border: quantity > 0 ? '2px solid #CD5C08' : '2px solid transparent',  // Change border when quantity > 0
            transition: 'border-color 0.3s ease',  // Smooth transition
            borderRadius: "24px",
            width: "170px",
          }}
          >
            {/* Remove Button */}
            <IconButton onClick={handleRemove}>
              <RemoveCircleOutlineRounded />
            </IconButton>

            {/* Display Quantity */}
            <Typography variant="h6" mx="15px">
              {quantity}
            </Typography>

            {/* Add Button */}
            <IconButton onClick={handleAdd}>
              <AddCircleOutlineRounded />
            </IconButton>
          </Box>
        )}
      </Box>
    </Box>
  );
};

export default MenuPic;
