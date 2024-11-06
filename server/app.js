const express = require('express');
const app = express();
const cors = require('cors');
const path = require("path");
const userConfig = require('./config/user-config');
const prodCat = require('./app/product/app-prod-category');
const store = require('./app/settings/app-setting-store');
const receiptTemp = require('./app/settings/app-setting-receipt-temp');
const tax = require('./app/settings/app-setting-tax');
const prod = require('./app/product/app-prod-setup');
const meal = require('./app/settings/app-setting-meal-period');
const pymt = require('./app/settings/app-setting-pymt-mode');
const table = require('./app/settings/app-setting-table');
const tableSec = require('./app/settings/app-setting-table-sec');
const customer = require('./app/app-customer');
const supplier = require('./app/app-supplier');
const generalSet = require('./app/settings/app-setting-general');
const usergrp = require('./app/user/app-user-group');
const user = require('./app/user/app-users');

app.use(cors());
app.use(express.json());

// Serve static files from the 'product-file' directory
app.use('/il', express.static(path.join(__dirname, 'app/product-file')));

app.use('/prodCat', prodCat);
app.use('/store', store);
app.use('/receiptTemp', receiptTemp);
app.use('/tax', tax);
app.use('/prod', prod);
app.use('/mp', meal);
app.use('/pm', pymt);
app.use('/ts', tableSec);
app.use('/t', table);
app.use('/cus', customer);
app.use('/spl', supplier);
app.use('/gs', generalSet);
app.use('/ug', usergrp);
app.use('/u', user);

app.listen(userConfig.PORT, () => {
    console.log(`Server running on PORT: ${userConfig.PORT}`);
});