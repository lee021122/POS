import { Box, Typography, IconButton, useMediaQuery, useTheme } from "@mui/material";
import { tokens } from "../../theme";

const zone = [
   {title: "Zone A"},
   {title: "Zone B"},
   {title: "Zone C"},


  ];

const Table = () => {
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    const isXlDevices = useMediaQuery("(min-width: 1260px)");
    const isMdDevices = useMediaQuery("(min-width: 724px)");
    const isXsDevices = useMediaQuery("(max-width: 436px)");
    return (
        
        <Box mx="15px">
            <Box
                display="grid"
                gridTemplateColumns={
                isXlDevices
                    ? "repeat(12, 1fr)"
                    : isMdDevices
                    ? "repeat(6, 1fr)"
                    : "repeat(3, 1fr)"
                }
                gridAutoRows="140px"
                gap="10px"
                >
                    <Box
                    display="flex"
                    alignItems="center"
                    justifyContent="space-between"
                    px={2}
                    backgroundColor={colors.primary[400]}
                    gridColumn="span 12"
                    height="50px"
                    >
                        {categories.map((category, index) => (
                            <Box
                            key={index}
                            bgcolor={colors.primary[400]}
                            display="flex"
                            flexDirection="column"
                            justifyContent="center"
                            alignItems="center"
                            width="120px"
                            height="120px"
                            p="10px"
                            ml="3.5px"
                            mr="3.5px"
                            borderRadius="12px"
                            boxShadow="0px 4px 12px rgba(0, 0, 0, 0.20)"
                            sx={{
                                backgroundColor: selectedCategory === category.title ? "#FFE7D1" : colors.primary[400], // Change background color if selected
                                color: selectedCategory === category.title ? "#CD5C08" : "inherit", // Change text color if selected
                                "&:hover": {
                                backgroundColor: "#FFE7D1",
                                color: "#CD5C08",
                                },
                                cursor: "pointer", 
                            }}
                            onClick={() => handleCategoryClick(category.title)} 
                            >
                            <Zone
                                title={category.title}
                                count={category.count}
                                icon={<img src={category.icon} alt={category.title} style={{ width: "25px", height: "25px" }} />}
                            />
                            </Box>
                        ))}
                    </Box>
            </Box>
        </Box>
      );

};

export default Table;
