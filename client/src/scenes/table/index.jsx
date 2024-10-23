import { Box, Typography, useMediaQuery, useTheme } from "@mui/material";
import { tokens } from "../../theme";
import Zone from "./zone";
import TableType from "./TableType";

import { useState } from "react";

const zones = [
  { title: "Zone A" },
  { title: "Zone B" },
  { title: "Zone C" },
];

const table_type = [
    { title: "2-Persons Table" },
    { title: "4-Persons Table" },
    { title: "6-Persons Table" },
  ];

const Table = () => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  const isXlDevices = useMediaQuery("(min-width: 1260px)");
  const isMdDevices = useMediaQuery("(min-width: 724px)");
  const isXsDevices = useMediaQuery("(max-width: 436px)");

  // State to manage the selected zone
  const [selectedZone, setSelectedZone] = useState(null);

  // Handle click to select zone
  const handleZoneClick = (zoneTitle) => {
    setSelectedZone(zoneTitle);
  };

  return (
    <Box mx="15px">
        {/* Zone Area */}
        <Box
            display="flex"
            flexDirection="row"
            gridAutoRows="140px"
            // gap="10px"
            bgcolor={colors.primary[400]}
            >
            {zones.map((zone, index) => (
            <Box
                key={index}
                bgcolor={colors.primary[400]}
                display="flex"
                flexDirection="column"
                justifyContent="center"
                alignItems="center"
                width="120px"
                p="5px"
                m="5px"
                borderRadius="12px"
                sx={{
                    border: "1.5px solid",         
                    borderRadius: "24px",
                    borderColor:selectedZone === zone.title ? "colors.primary[400]" : "#f2f0f0",
                    backgroundColor:selectedZone === zone.title ? "colors.primary[400]" : "#f2f0f0", // Change background color if selected
                    color: selectedZone === zone.title ? "#CD5C08" : "#7D7C7C", // Change text color if selected
                "&:hover": {
                    backgroundColor: colors.primary[400],
                    borderColor: "#CD5C08",
                },
                cursor: "pointer",
                }}
                onClick={() => handleZoneClick(zone.title)} // Handle zone click
            >
                <Zone title={zone.title} />
            </Box>
            ))}
        </Box>
        {/* Status Legend */}
        <Box 
            mx="20px"
            my="10px"
            display="flex"
            alignItems="center"
            justifyContent="right"
            >
            {/* Available */}
            <Box display="flex" alignItems="center" mx="15px">
                <Box
                sx={{
                    width: "10px",  
                    height: "10px",
                    borderRadius: "50%", 
                    backgroundColor: "grey", 
                    mr: "8px", 
                }}
                />
                <Typography variant="h6" color="black" textAlign="left">
                Available
                </Typography>
            </Box>

            {/* Occupied */}
            <Box display="flex" alignItems="center" mx="15px">
                <Box
                sx={{
                    width: "10px",
                    height: "10px",
                    borderRadius: "50%",
                    backgroundColor: "green",
                    mr: "8px",
                }}
                />
                <Typography variant="h6" color="black" textAlign="left">
                Occupied
                </Typography>
            </Box>

            {/* Reserved */}
            <Box display="flex" alignItems="center" mx="15px">
                <Box
                sx={{
                    width: "10px",
                    height: "10px",
                    borderRadius: "50%",
                    backgroundColor: "red", 
                    mr: "8px",
                }}
                />
                <Typography variant="h6" color="black" textAlign="left">
                Reserved
                </Typography>
            </Box>
            </Box>



        {/* Table Type */}
        {table_type.map((type, index) => (
        <Box
            display="flex"
            flexDirection="column"
            gridAutoRows="140px"
            // gap="10px"
            mt="10px"
            height="auto"
            bgcolor={colors.primary[400]}
            >
                <Box mt="5px">
                    <Typography variant="h7" ml="10px"  fontWeight="bold">
                    {type.title}
                    </Typography>
                </Box>
                <Box 
                    m="10px"
                    display="flex"
                    flexDirection="row"
                    // justifyContent="center"
                    // alignItems="center"
                >
                {table_type.map((type, index) => (

                    <TableType/>
                ))}

                </Box>

        </Box>
        ))}
    </Box>
  );
};

export default Table;
