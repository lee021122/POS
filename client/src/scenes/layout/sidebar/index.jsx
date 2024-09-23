/* eslint-disable react/prop-types */
import { Avatar, Box, IconButton, Typography, useTheme, useMediaQuery} from "@mui/material";
import { useContext, useState } from "react";
import { tokens } from "../../../theme";
import { Menu, MenuItem, Sidebar } from "react-pro-sidebar";
import {
  TableBarOutlined,
  BorderColorOutlined,
  DashboardOutlined,
  MenuOutlined,
  PaymentsOutlined,
  HistoryOutlined,
} from "@mui/icons-material";

import food from "../../../assets/images/foodie.png";

import Item from "./Item";
import { ToggledContext } from "../../../App";

const SideBar = () => {
  const isXlDevices = useMediaQuery("(min-width: 1260px)");
  const isMdDevices = useMediaQuery("(min-width: 724px)");
  const isXsDevices = useMediaQuery("(max-width: 450px)");
  const [collapsed, setCollapsed] = useState(false);
  const { toggled, setToggled } = useContext(ToggledContext);
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  return (
    <Sidebar
      backgroundColor={colors.primary[400]}
      rootStyles={{
        border: 0,
        height: "100%",
      }}
      collapsed={collapsed}
      onBackdropClick={() => setToggled(false)}
      toggled={toggled}
      breakPoint="md"
    >
      <Menu
        menuItemStyles={{
          button: { ":hover": { background: "transparent" } },
        }}
      >
        <MenuItem
          rootStyles={{
            margin: "10px 0 20px 0",
            color: colors.gray[100],
          }}
        >
          <Box
            sx={{
              display: "flex",
              alignItems: "center",
              justifyContent: "space-between",
            }}
          >
            {!collapsed && (
              // product logo
              <Box
                display="flex"
                alignItems="center"
                gap="12px"
                sx={{ transition: ".3s ease" }}
              >
                <img
                  style={{ width: "50px", height: "50px", borderRadius: "8px" }}
                  src={food}
                  alt="POS"
                />
                <Typography
                  variant="h4"
                  fontWeight="bold"
                  textTransform="capitalize"
                  color={"#557C56"}
                >
                  Restaurant
                </Typography>
                
              </Box>
            )}
            {!isXsDevices && (
              <IconButton onClick={() => setCollapsed(!collapsed)}>
                <MenuOutlined />
              </IconButton>
            )}
          </Box>
        </MenuItem>
      </Menu>
      

      <Box  pr={collapsed ? undefined:"5%"} pl={collapsed ? undefined : "5%"}>
        <Menu
          menuItemStyles={{
            button: {
              ":hover": {
                color: "#FF885B",
                background: "transparent",
                transition: ".4s ease",
              },
            },
          }}
        >
          <Item
            title="Dashboard"
            path="/"
            colors={colors}
            icon={<DashboardOutlined />}
          />
        </Menu>
        <Typography
          variant="h6"
          color={"#7D7C7C"}
          sx={{ m: "15px 0 5px 20px", textTransform: "uppercase", fontWeight: "bold" }}
        >
          {!collapsed ? "Services" : " "}
        </Typography>{" "}
        <Menu
          menuItemStyles={{
            button: {
              ":hover": {
                color: "#FF885B",
                background: "transparent",
                transition: ".4s ease",
              },
            },
          }}
        >
          <Item
            title="Order"
            path="/order"
            colors={colors}
            icon={<BorderColorOutlined />}
          />
          <Item
            title="Payment & Billing "
            path="/contacts"
            colors={colors}
            icon={<PaymentsOutlined />}
          />
          <Item
            title="Table Location"
            path="/table"
            colors={colors}
            icon={<TableBarOutlined />}
          />
           <Item
            title="Order History"
            path="/invoices"
            colors={colors}
            icon={<HistoryOutlined />}
          />
        </Menu>
        <Typography
          variant="h6"
          color={"#7D7C7C"}
          sx={{ m: "15px 0 5px 20px", textTransform: "uppercase", fontWeight: "bold" }}
        >
          {!collapsed ? "Settings" : " "}
        </Typography>
        <Menu
          menuItemStyles={{
            button: {
              ":hover": {
                color: "#FF885B",
                background: "transparent",
                transition: ".4s ease",
              },
            },
          }}
        >
          {/* <Item
            title="Profile Form"
            path="/form"
            colors={colors}
            icon={<PersonOutlined />}
          />
          <Item
            title="Calendar"
            path="/calendar"
            colors={colors}
            icon={<CalendarTodayOutlined />}
          />
          <Item
            title="FAQ Page"
            path="/faq"
            colors={colors}
            icon={<HelpOutlineOutlined />}
          /> */}
        </Menu>
        <Typography
          variant="h6"
          color={"#7D7C7C"}
          sx={{ m: "15px 0 5px 20px", textTransform: "uppercase", fontWeight: "bold" }}
        >
          {!collapsed ? "Reports" : " "}
        </Typography>
        <Menu
          menuItemStyles={{
            button: {
              ":hover": {
                color: "#FF885B",
                background: "transparent",
                transition: ".4s ease",
              },
            },
          }}
        >
          {/* <Item
            title="Bar Chart"
            path="/bar"
            colors={colors}
            icon={<BarChartOutlined />}
          />
          <Item
            title="Pie Chart"
            path="/pie"
            colors={colors}
            icon={<DonutLargeOutlined />}
          />
          <Item
            title="Line Chart"
            path="/line"
            colors={colors}
            icon={<TimelineOutlined />}
          />
          <Item
            title="Geography Chart"
            path="/geography"
            colors={colors}
            icon={<MapOutlined />}
          />
          <Item
            title="Stream Chart"
            path="/stream"
            colors={colors}
            icon={<WavesOutlined />}
          /> */}
        </Menu>
      </Box>
    </Sidebar>
  );
};

export default SideBar;
