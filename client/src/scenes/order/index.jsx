import React, { useState } from "react";
import { Box, useMediaQuery, useTheme } from "@mui/material";
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

const CategoryType = [
  { title: "All", icon: AllIcon },
  { title: "Main Course", icon: MainCourseIcon },
  { title: "Pasta", icon: PastaIcon },
  { title: "Burger", icon: BurgerIcon },
  { title: "Breakfast", icon: BreakfastIcon },
  { title: "Dessert", icon: DessertIcon },
  { title: "Beverage", icon: BeverageIcon },
];

const menuItems = [
    {title: "Nasi Goreng Kampung",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng USA",image: nasi,price: "RM16.90", category: "Main Course",},
    {title: "Nasi Goreng Cili Padi",image: NGK,price: "RM16.90", category: "Main Course",},
    {title: "Ice Cream",image: NGK,price: "RM16.90", category: "Dessert",},


  ];

function Order() {
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    const isXlDevices = useMediaQuery("(min-width: 1260px)");
    const isMdDevices = useMediaQuery("(min-width: 724px)");
    const isXsDevices = useMediaQuery("(max-width: 436px)");

    // State to store the selected category
    const [selectedCategory, setSelectedCategory] = useState("All");

    // Function to handle category selection
    const handleCategoryClick = (category) => {
      setSelectedCategory(category);
    };

    
    // Calculate the count for each category dynamically
    const categoryCounts = menuItems.reduce((acc, item) => {
      acc[item.category] = (acc[item.category] || 0) + 1;
      return acc;
    }, {});

    // Add the total count for "All"
    const totalItemCount = menuItems.length;

    // Update categories with dynamic counts
    const categories = CategoryType.map((category) => {
      if (category.title === "All") {
        return { ...category, count: `${totalItemCount} items` };
      }
      const categoryCount = categoryCounts[category.title] || 0;
      return { ...category, count: `${categoryCount} items` };
    });

    // Filter menu items based on selected category
    const filteredMenuItems = selectedCategory === "All"? menuItems: menuItems.filter((item) => item.category === selectedCategory);


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
                  width="120px"
                  height="120px"
                  p="10px"
                  ml="3.5px"
                  mr="3.5px"
                  borderRadius="15px"
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
                  <CategoriesBox
                    title={category.title}
                    count={category.count}
                    icon={<img src={category.icon} alt={category.title} style={{ width: "25px", height: "25px" }} />}
                  />
                </Box>
              ))}
            </Box>
    
            {/* Order Part */}
            <Box
              gridColumn={isXlDevices ? "span 3" : "span 3"}
              gridRow="span 6"
              backgroundColor={colors.primary[400]}
              border="1px solid #ccc"
              borderRadius="5px"
            >
              <OrderListing order_num={"#000"} />
            </Box>
    
            {/* Menu Items */}
            <Box
              backgroundColor="transparent"
              gridColumn="span 9"
              gridRow="span 5"
              display="grid"
              gridTemplateColumns="repeat(auto-fill, minmax(200px, 1fr))"
              gap="10px"
              maxWidth="100%"
              maxHeight="270px"
              overflow="auto"
              mb="50px"
              pl="5px"
              pr="5px"
            >
              {filteredMenuItems.map((item, index) => (
                <Box
                  key={index}
                  backgroundColor={colors.primary[400]}
                  display="flex"
                  flexDirection="column"
                  alignItems="center"
                  justifyContent="center"
                  p="15px"
                >
                  <Box display="flex" alignItems="center" justifyContent="center">
                    <MenuPic
                      title={item.title}
                      image={<img src={item.image} style={{ width: "170px", height: "130px", borderRadius: "15px" }} />}
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