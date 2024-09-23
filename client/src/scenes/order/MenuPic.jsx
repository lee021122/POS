import { Box, Typography, Button, IconButton } from "@mui/material";
import { RemoveCircleOutlineRounded, AddCircleOutlineRounded } from '@mui/icons-material';

const MenuPic = ({ id, title, image, price, category, quantity, onAdd, onRemove }) => {

  return (
    <Box width="100%">
      <Box display="flex" flexDirection="column" alignItems="center">
        {image}
        <Typography variant="h6" fontWeight="bold" color={"#557C56"} mt="20px" align="center">
          {title}
        </Typography>
        <Typography variant="h6" color="#757575">
          RM{price.toFixed(2)}
        </Typography>
        
        {/* Conditionally render Add to Dish button or the counter based on the quantity */}
        {quantity === 0 ? (
          <Button
            variant="contained"
            onClick={onAdd}
            sx={{
              backgroundColor: "#CD5C08", 
              fontWeight: "bold", 
              width: "170px", 
              mt: "10px", 
              borderRadius: "24px", 
              height: "35px",
              '&:hover': {
                backgroundColor: "#FFE7D1",
                color: "#CD5C08",
              }
            }}
          >
            Add to Dish
          </Button>
        ) : (
          <Box display="flex" alignItems="center" justifyContent="space-between"
            sx={{
              border: quantity > 0 ? '2px solid #CD5C08' : '2px solid transparent',
              transition: 'border-color 0.3s ease',
              borderRadius: "24px",
              width: "170px",
              mt: "10px",
              height:"35px"
            }}
          >
            {/* Remove Button */}
            <IconButton onClick={onRemove}>
              <RemoveCircleOutlineRounded />
            </IconButton>

            {/* Display Quantity */}
            <Typography variant="h6" mx="15px">
              {quantity}
            </Typography>

            {/* Add Button */}
            <IconButton onClick={onAdd}>
              <AddCircleOutlineRounded />
            </IconButton>
          </Box>
        )}
      </Box>
    </Box>
  );
};

export default MenuPic;
