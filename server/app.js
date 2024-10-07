const express = require('express');
const app = express();
const cors = require('cors');
const userConfig = require('./config/user-config');
const prodCat = require('./app/app-prod-category');
const store = require('./app/app-setting-store');
const receiptTemp = require('./app/app-setting-receipt-temp');
const tax = require('./app/app-setting-tax');
const prod = require('./app/app-prod-setup');
const meal = require('./app/app-setting-meal-period');
const pymt = require('./app/app-setting-pymt-mode');
const table = require('./app/app-setting-table');
const tableSec = require('./app/app-setting-table-sec');
const customer = require('./app/app-customer');
const supplier = require('./app/app-supplier');

app.use(cors());
app.use(express.json());

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

app.listen(userConfig.PORT, () => {
    console.log(`Server running on PORT: ${userConfig.PORT}`);
});