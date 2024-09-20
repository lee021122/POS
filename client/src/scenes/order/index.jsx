import React from "react";
import {
    Box,
    useMediaQuery,
    useTheme,
} from "@mui/material";
import {
    CategoriesBox,
    MenuPic,
} from "../../components";

import AllIcon from "../../assets/images/all.png";
import MainCourseIcon from "../../assets/images/main.png";
import PastaIcon from "../../assets/images/pasta.png";
import BurgerIcon from "../../assets/images/burger.png";
import BreakfastIcon from "../../assets/images/breakfast.png";
import DessertIcon from "../../assets/images/dessert.png";
import BeverageIcon from "../../assets/images/beverage.png";
import NGK from "../../assets/images/nasi.jpeg";
import nasi from "../../assets/images/nasi.jpg";


import { tokens } from "../../theme";
import OrderListing from "./OrderListing";

const categories = [
    { title: "All", icon: AllIcon, count: "157 items" },
    { title: "Main Course", icon: MainCourseIcon, count: "67 items" },
    { title: "Pasta", icon: PastaIcon, count: "14 items" },
    { title: "Burger", icon: BurgerIcon, count: "3 items" },
    { title: "Breakfast", icon: BreakfastIcon, count: "19 items" },
    { title: "Dessert", icon: DessertIcon, count: "22 items" },
    { title: "Beverage", icon: BeverageIcon, count: "17 items" },
    { title: "All", icon: AllIcon, count: "157 items" },
    { title: "Main Course", icon: MainCourseIcon, count: "67 items" },
    { title: "Pasta", icon: PastaIcon, count: "14 items" },
    { title: "Burger", icon: BurgerIcon, count: "3 items" },
    { title: "Breakfast", icon: BreakfastIcon, count: "19 items" },
    { title: "Dessert", icon: DessertIcon, count: "22 items" },
    { title: "Beverage", icon: BeverageIcon, count: "17 items" },
]

const menuItems = [
    {title: "Nasi Goreng Kampung",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng Kampung",image: nasi,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng Kampung",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng USA",image: nasi,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng USA",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng USA",image: nasi,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng Kampung",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng Kampung",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng USA",image: nasi,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng USA",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng USA",image: nasi,price: "RM16.90", category: "Main Course",},

  ];

function Order() {
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    const isXlDevices = useMediaQuery("(min-width: 1260px)");
    const isMdDevices = useMediaQuery("(min-width: 724px)");
    const isXsDevices = useMediaQuery("(max-width: 436px)");
    return (
      <Box m="15px">
          
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
          {/* Category Items */}

          <Box 
            backgroundColor="transparent"
            gridColumn="span 9"
            display="flex"
            alignItems="center"
            // borderRadius="20px"
            // boxShadow="0px 4px 12px rgba(0, 0, 0, 0.15)"
            pl="5px"
            pr="5px"

            maxWidth="100%" 
            overflow="auto"
            whiteSpace="nowrap" 
            sx={{
                "::-webkit-scrollbar": {
                  display: "none", // Hides the scrollbar in Chrome, Safari, and other WebKit browsers
                },
                scrollbarWidth: "none", // Hides the scrollbar in Firefox
              }}
            >
            {categories.map((category, index) => (
                <Box
                key={index}
                bgcolor={colors.primary[400]}
                display="flex"
                flexDirection="column"
                justifyContent="center"
                alignItems="center"
                width="120px" // Set a fixed width for each item box
                height="120px"
                p="10px"
                ml="3.5px"
                mr="3.5px" // Add some margin between items
                borderRadius="15px" // Add border radius to each item
                boxShadow="0px 4px 12px rgba(0, 0, 0, 0.20)" // Optional: shadow for each item
                sx={{ 
                    '&:hover': {
                    backgroundColor: "#FFE7D1",
                    color: "#CD5C08", // Change to your desired hover color
                  }
                  }}
                >
                <CategoriesBox
                    title={category.title}
                    count={category.count}
                    icon={<img src={category.icon} alt={category.title} style={{ width: '25px', height: '25px' }} />}
                />
                </Box>
            ))}
            </Box>

             {/* Order Part */}

              <Box
                gridColumn={isXlDevices ? "span 3" : "span 3"}
                gridRow="span 6"
                backgroundColor={colors.primary[400]}
              >


              <OrderListing 
                order_num={"#000"}
              />
                
            </Box>

            

          {/* Menu Item */}

          <Box 
            backgroundColor="transparent"
            gridColumn="span 9"
            gridRow="span 5"
            display="grid"
            gridTemplateColumns="repeat(auto-fill, minmax(200px, 1fr))" // Responsive grid with min-width for each item
            gap="10px" // Space between grid items
            maxWidth="100%" 
            overflow="auto"
            mb="50px"
            pl="2px"
            pr="2px"
            >
            {menuItems.map((item, index) => (
                <Box
                key={index}
                backgroundColor={colors.primary[400]}
                display="flex"
                flexDirection="column"
                alignItems="center"
                justifyContent="center"
                p="15px"
                
                >
                <Box
                    display="flex"
                    alignItems="center"
                    justifyContent="center"
                    // mt="8px"
                >
                    <MenuPic
                    title={item.title}
                    image={<img src={item.image} style={{ width: '170px', height: '130px', borderRadius: '15px' }} />}
                    price={item.price}
                    category={item.category}
                    />
                </Box>
                </Box>
            ))}
            </Box>

           
        </Box>
      </Box>
    );
  }

export default Order;
