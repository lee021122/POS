import { Box, Typography, useTheme } from "@mui/material";
import { tokens } from "../../theme";



const Zone = ({ title}) => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  return (
    <Box width="100%"
     sx={{
        display: "flex",           // Enable flexbox
        alignItems: "center",      // Vertical centering
        justifyContent: "center",  // Horizontal centering
      }}
    >
          <Typography variant="h7">
            {title}
          </Typography>
    </Box>
  );
};

export default Zone;