/* eslint-disable react/prop-types */
import { Box, Typography, useTheme } from "@mui/material";
import { tokens } from "../../theme";

const CategoriesBox = ({ title, icon, count }) => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  return (
    <Box width="100%" mx="20px" 
    >
          {icon}
          <Typography variant="h6" fontWeight="bold" color={"#557C56"}>
            {title}
          </Typography>
          <Typography variant="h7" color={"#7D7C7C"}>
          {count}
        </Typography>        
    </Box>
  );
};

export default CategoriesBox;