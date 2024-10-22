/* eslint-disable react/prop-types */
import { Box, Typography, useTheme } from "@mui/material";
import { tokens } from "../../theme";



const Zone = ({ title}) => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  return (
    <Box width="100%" mx="20px" borderRadius={50}
    >
          <Typography variant="h7"  color={"#7D7C7C"}>
            {title}
          </Typography>
    </Box>
  );
};

export default Zone;