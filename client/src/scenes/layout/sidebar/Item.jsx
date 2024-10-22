import { MenuItem } from "react-pro-sidebar";
import { Link, useLocation } from "react-router-dom";
import { Typography, Box } from "@mui/material";


const Item = ({ title, path, icon }) => {
  const location = useLocation();
  const isSelected = path === location.pathname; 
  return (
    <MenuItem
      component={<Link to={path} />}
      to={path}
      icon={icon}
      rootStyles={{
        borderRadius: "5px",
        marginTop:"5px",
        fontWeight: "bold",
        backgroundColor: isSelected ? "#CD5C08" : "#fcfcfc", // Highlight selected item
        color: isSelected ? "#FFF5E4" : "#33372C", // Change color for selected item
        ":hover": {
          backgroundColor: "#FFE7D1", // Change background on hover
          color: "#CD5C08", // Change text color on hover
        },
        transition: "all 0.3s ease", // Smooth transition for hover effects
      }}
    >
      {title}
    </MenuItem>
  );
};

export default Item;