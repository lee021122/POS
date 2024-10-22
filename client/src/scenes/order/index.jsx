import React, { useState } from "react";
import { Box, useMediaQuery, useTheme, Button, Typography } from "@mui/material";
import { tokens } from "../../theme";

import {
    CategoriesBox,
    MenuPic,
} from "../../components";

import MainCourseIcon from "../../assets/images/main.png";
import nasi from "../../assets/images/nasi.jpg";


import OrderListing from "./OrderListing";
import MenuOrdered from "./MenuOrdered";

const CategoryType = [
  { title: "All", icon: MainCourseIcon },
  { title: "Main Course", icon: MainCourseIcon },
  { title: "Pasta", icon: MainCourseIcon },
  { title: "Burger", icon: MainCourseIcon },
  { title: "Breakfast", icon: MainCourseIcon },
  { title: "Dessert", icon: MainCourseIcon },
  { title: "Beverage", icon: MainCourseIcon },
];

const menuItems = [
    {id:1, title: "Nasi Goreng Kampung",image: nasi,price: 16.90, category: "Main Course",},
    {id:2, title: "Nasi Goreng USA",image: nasi,price: 6.90, category: "Main Course",},
    {id:3, title: "Nasi Goreng Cili Padi",image: nasi,price: 6.90, category: "Main Course",},
    {id:4, title: "Ice Cream",image: nasi,price: 16.90, category: "Dessert",},
    {id:5, title: "Nasi Goreng",image: nasi,price: 8.90, category: "Main Course",},
    

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
        return { ...category, count: `${totalItemCount} ${totalItemCount <= 1 ? 'item' : 'items'}` };
      }
      const categoryCount = categoryCounts[category.title] || 0;
      return { ...category, count: `${categoryCount} ${categoryCount <= 1 ? 'item' : 'items'}` };
    });

    // Filter menu items based on selected category
    const filteredMenuItems = selectedCategory === "All"? menuItems: menuItems.filter((item) => item.category === selectedCategory);

    // State to manage quantities for each MenuPic by id
    const [quantities, setQuantities] = useState({});

    // Function to handle incrementing the quantity for a specific item
    const handleAdd = (id) => {
      setQuantities((prevQuantities) => ({
        ...prevQuantities,
        [id]: (prevQuantities[id] || 0) + 1,
      }));
    };

    // Function to handle decrementing the quantity for a specific item
    const handleRemove = (id) => {
      setQuantities((prevQuantities) => ({
        ...prevQuantities,
        [id]: Math.max((prevQuantities[id] || 0) - 1, 0),
      }));
    };

    const orderedItems = menuItems.filter(item => quantities[item.id] > 0);

    const totalPrice = orderedItems.reduce((total, item) => total + item.price * quantities[item.id],0);

    const handleButtonClick = () => {
      console.log("Order placed");
      alert('Order placed successfully!');
      window.location.reload();


    };

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
              gridColumn= "span 3"
              height="700px"
              backgroundColor={colors.primary[400]}
              border="1px solid #ccc"
              borderRadius="5px"
              padding="0px"
              display="flex"
              flexDirection="column"
              justifyContent="space-between" 
            >
              <div>
                <OrderListing order_num={"#000"} />
                {orderedItems.map((item) => (
                  <MenuOrdered
                    key={item.id}
                    quantity={quantities[item.id]}
                    title={item.title}
                    price={item.price * quantities[item.id]}
                  />
                ))}
              </div>
         
              <Box display="flex" flexDirection="column" borderTop="1px solid #ccc">
                <Box 
                  mx="20px"
                  my="10px"
                  display="flex"
                  alignItems="center"
                  justifyContent="space-between"
                >
                  <Typography 
                    variant="h6" 
                    color={"black"}
                    fontWeight={"bold"} 
                    sx={{ 
                      textAlign: 'left', 
                      marginBottom: '10px' 
                    }}>
                    Total Price:
                  </Typography>
                  <Typography 
                    variant="h6" 
                    color={"black"} 
                    sx={{ 
                      textAlign: 'left', 
                      marginBottom: '10px' 
                    }}>
                    RM {totalPrice.toFixed(2)}
                  </Typography>
                </Box>
              

                <Button
                  onClick={() => {
                    handleButtonClick();
                  }}
                  variant="contained"
                  disabled={orderedItems.length === 0}
                  sx={{ 
                    width: '100%',
                    borderRadius: "0px",
                    fontWeight: "bold",
                    backgroundColor: "#CD5C08",
                    color: "#FFF5E4",

                    ":hover": {
                      backgroundColor: "#FFE7D1", // Change background on hover
                      color: "#CD5C08", // Change text color on hover
                    },
                    transition: "all 0.3s ease", // Smooth transition for hover effects
                  }}
                >
                  Place Order
                </Button>

            </Box>
            </Box>

    
            {/* Menu Items */}
            <Box
              backgroundColor="transparent"
              gridColumn="span 9"
              height="550px"
              display="grid"
              gridTemplateColumns="repeat(auto-fill, minmax(200px, 1fr))"
              gap="10px"
              maxWidth="100%"
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
                  // p="15px"
                  height="350px"

                >
                  <Box 
                    display="flex" 
                    alignItems="center" 
                    justifyContent="center"
                   >
                    <MenuPic
                      id={item.id}
                      title={item.title}
                      image={<img src={item.image} style={{ width: "70%", height: "60%", borderRadius: "15px" }} />}
                      price={item.price}
                      category={item.category}
                      quantity={quantities[item.id] || 0} 
                      onAdd={() => handleAdd(item.id)} 
                      onRemove={() => handleRemove(item.id)} 
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
