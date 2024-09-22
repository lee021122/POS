import { Box, Typography } from "@mui/material";

const MenuOrdered = ({ quantity, title, price }) => {
  return (
    <Box 
      borderBottom="1px solid #ccc"
    >
        <Box
            mx="20px"
            my="20px"
            display="flex"
            alignItems="center"
            justifyContent="space-between"
        >
        <Box
            bgcolor="#33372C"
            p="5px"
            borderRadius="5px"
            minWidth={40}
            display="flex"
            justifyContent="center"
            alignItems="center"
        >
            <Typography variant="h6" fontWeight="bold" color="white">
            x{quantity}
            </Typography>
        </Box>

        <Box display="flex" flexGrow={1} ml="10px">
            <Typography variant="h6" fontWeight="bold" color="#33372C" flexGrow={1}>
            {title}
            </Typography>

            <Typography variant="h7" color="black" textAlign="right">
            {price}
            </Typography>
        </Box>
        </Box>
    </Box>
  );
};

export default MenuOrdered;
