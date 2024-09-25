import React, { useState } from 'react';
import { Link } from 'react-router-dom';

// material-ui
import { Card, CardContent, Grid, Typography, Button, Divider, Box } from '@mui/material';

// project import
import Breadcrumb from 'component/Breadcrumb';
import { gridSpacing } from 'config.js';

import MenuCategory from './MenuCategory';
import OrderDetails from './OrderDetails';
import MenuOrdered from './MenuOrdered';

const Order = () => {
  const [orderedItems, setOrderedItems] = useState([]);

  // Function to add an item to the order by its id
  const addToOrder = (item) => {
    setOrderedItems(prevItems => {
      const existingItem = prevItems.find(orderedItem => orderedItem.id === item.id);
      if (existingItem) {
        return prevItems.map(orderedItem =>
          orderedItem.id === item.id
            ? { ...orderedItem, quantity: orderedItem.quantity + 1 }
            : orderedItem
        );
      }
      return [...prevItems, { ...item, quantity: 1 }];
    });
  };

  // Function to remove an item from the order if the quantity is zero
  const handleRemoveItem = (id) => {
    setOrderedItems(prevItems => prevItems.filter(item => item.id !== id));
  };

  // Function to update the quantity of an item
  const updateQuantity = (id, newQuantity) => {
    setOrderedItems(prevItems =>
      prevItems.map(item =>
        item.id === id ? { ...item, quantity: newQuantity } : item
      )
    );
  };

  const getTotalPrice = () => {
    return orderedItems.reduce((total, item) => total + item.count * item.quantity, 0);
  };

  const handlePlaceOrder = () => {
    alert('Order placed successfully!');
    window.location.reload();
  };

  return (
    <>
      <Breadcrumb>
        <Typography
          component={Link}
          to="/"
          variant="subtitle2"
          color="inherit"
          className="link-breadcrumb"
        >
          Home
        </Typography>
        <Typography variant="subtitle2" color="primary" className="link-breadcrumb">
          Order Page
        </Typography>
      </Breadcrumb>

      <Grid container spacing={gridSpacing} padding="0px">
        {/* Grid for Menu Category */}
        <Grid item xl={9} lg={8} sm={8} xs={12}>
          <Card
            sx={{
              width: '100%',
              margin: 'auto',
              display: 'flex',
              flexDirection: 'column',
            }}
          >
            <MenuCategory addToOrder={addToOrder} />
          </Card>
        </Grid>

        <Grid item xl={3} lg={4} sm={4} md={4} xs={12}>
          <Card
            sx={{
              width: '100%',
              display: 'flex',
              flexDirection: 'column',
              justifyContent: 'space-between', // Ensure space between content and bottom
              overflow: 'hidden',
              height: {
                xs: '440px',
                sm: '490px',
                md: '600px',
                lg: '640px',
                xl: '700px',
                xxl: '1095px'
              },
            }}
          >
            <OrderDetails order_num={"#000"} />

            {/* Ordered items scrollable section */}
            <Box sx={{ flexGrow: 1, overflowY: 'auto', padding: '0px' }}>
              {orderedItems.map((item) => (
                <MenuOrdered
                  key={item.id}
                  id={item.id}
                  title={item.title}
                  price={item.count}
                  quantity={item.quantity}
                  onRemoveItem={handleRemoveItem}
                  updateQuantity={updateQuantity}
                />
              ))}
            </Box>

            {/* Divider */}
            <Divider />

            {/* Fixed total price and place order button at the bottom */}
            <Box>
              {/* Total Price */}
              <CardContent>
                <Typography variant="h6"  align="right">
                  Total: RM{getTotalPrice().toFixed(2)}
                </Typography>
              </CardContent>

              {/* Place Order Button */}
              <CardContent>
                <Button
                  variant="contained"
                  fullWidth
                  onClick={handlePlaceOrder}
                  disabled={orderedItems.length === 0} // Disable if no items in order
                  sx={{
                    backgroundColor:"#FFB000",
                    color:"#000",
                    '&:hover': {
                      backgroundColor:"#F7E6C4",
                    }
                  }}
                >
                  Place Order
                </Button>
              </CardContent>
            </Box>
          </Card>
        </Grid>
      </Grid>
    </>
  );
};

export default Order;
