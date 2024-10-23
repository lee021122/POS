import { Box, Typography, useTheme } from "@mui/material";
import { tokens } from "../../theme";

const TableType = ({}) => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);

  return (
    <Box
      display="flex"
      alignItems="center"
      justifyContent="center"
      flexDirection="column"
      width="120px"
      height="120px"
      mx="3.5px"
      borderRadius="12px"
      sx={{
        backgroundColor: "#f2f0f0", // Change background color if selected
        color: "inherit", // Change text color if selected
        "&:hover": {
          backgroundColor: "#FFE7D1",
          color: "#CD5C08",
        },
        cursor: "pointer",
      }}
    >
      {/* Box containing "A-01" */}
      <Box
      
        px="15px"
        py="5px"
        borderRadius="24px"
        bgcolor={"grey"}
        mb="5px"
        mt="10px"
      >
        <Typography variant="h8" align="center">
          A-01
        </Typography>
      </Box>

      {/* "0 guest" text */}
      <Typography variant="h7" align="center" mb="12px">
        0 guest
      </Typography>

      {/* Space before "status" */}
      <Box m="auto" pt="12px" >
        <Typography variant="h7" align="center">
          status
        </Typography>
      </Box>
    </Box>
  );
};

export default TableType;
