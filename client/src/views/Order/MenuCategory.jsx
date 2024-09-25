import * as React from 'react';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import Tab from '@mui/material/Tab';
import TabContext from '@mui/lab/TabContext';
import TabList from '@mui/lab/TabList';

import MenuCard from './MenuCard';

const items = [
  {id:1, title: 'Scrambled Eggs', count: 10, category: 'Starters' },
  {id:2, title: 'Fruits', count: 15.50, category: 'Starters' },
  {id:3, title: 'Buttter Toast', count: 12, category: 'Starters' },
  {id:4,title: 'Boiled Eggs', count: 14 , category: 'Starters' },
  {id:5, title: 'Apple', count: 7.90, category: 'Starters' },
  {id:6, title: 'Butter', count: 8.10, category: 'Starters' },
  {id:8, title: 'Tuna Sandwich', count: 10, category: 'Breakfast' },
  {id:9, title: 'Chocolate Slice Cake', count: 10.50, category: 'Dessert' },
  {id:10, title: 'Ice Cream', count: 8.90, category: 'Dessert' },
 
 
];
const MenuCategory = ({ addToOrder }) => {

  const [value, setValue] = React.useState('All'); 

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  // Function to filter and render MenuCards based on the selected category
  const renderMenuCards = () => {
    const filteredItems = value === 'All' ? items : items.filter(item => item.category === value);
  
    return (
      <Box 
        display="grid"
        gridTemplateColumns="repeat(auto-fill, minmax(200px, 1fr))"
        gap="10px"
      >
        {filteredItems.map((item) => (
          <Box
            key={item.id}
            backgroundColor={"#F5F5DC"}
            display="flex"
            flexDirection="column"
            sx={{
              '&:hover': {
                border: "2px solid #557C56",
              }
            }}
            onClick={() => addToOrder(item)} // Call addToOrder when clicked
          >
            <MenuCard
              title={item.title}
              count={item.count}
              category={item.category}
            />
          </Box>
        ))}
      </Box>
    );
  };
  

  return (
    <Box 
    
    >
      <Box sx={{ width: '100%', typography: 'body1' }}>
        <TabContext value={value}>
          <Box
            sx={{ borderBottom: 1, borderColor: 'divider' }}>
            <TabList
              onChange={handleChange}
              aria-label="menu categories"
              variant="scrollable" // Enable scrolling for tabs
              scrollButtons="auto" // Show scroll buttons automatically when needed
              allowScrollButtonsMobile // Allows scroll buttons on mobile devices
            >            
              <Tab label="All" value="All" /> 
              <Tab label="Starters" value="Starters" />
              <Tab label="Breakfast" value="Breakfast" />
              <Tab label="Dessert" value="Dessert" />
              <Tab label="Soups" value="Soups" />
              <Tab label="Pasta" value="Pasta" />
              <Tab label="Beverages" value="Beverages" />
              <Tab label="Main Course" value="MainCourse" />
             
            </TabList>
          </Box>

          {/* Conditionally render MenuCards based on the selected category */}
          <Box 
          sx={{
            p: "10px",
            overflow: 'auto',  // Enable scroll
            height: {
              xs: '400px', // Adjust for small screens
              sm: '440px', // Adjust for screens >= 768px
              md: '580px', // Adjust for screens >= 1024px
              lg: '590px', // Adjust for screens >= 1266px
              xl: '700px', // Adjust for screens >= 1440px
              xxl: '1050px'
            },
            "::-webkit-scrollbar": {
              display: "none", // Hides the scrollbar in Chrome, Safari, and other WebKit browsers
            },
            scrollbarWidth: "none", // Hides the scrollbar in Firefox
          }}
        >
          {renderMenuCards()}
        </Box>
        </TabContext>
      </Box>
    </Box>
  );
};

export default MenuCategory;
