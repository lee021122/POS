import { Box, Typography, } from "@mui/material";

const MenuCard = ({ title, count, category }) => {

  return (
    <Box width="100%"  
    >
        <Box 
            margin={4}
            
        >
          {/* {icon} */}
          <Typography variant="h7" color={"#557C56"}>
            {title}
          </Typography>
          <Typography variant="h6" color={"#7D7C7C"} fontWeight="bold">
          RM{count.toFixed(2)}
        </Typography>
        </Box>
    </Box>
  );
};

export default MenuCard;