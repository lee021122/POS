const express = require('express');
const app = express();
const cors = require('cors');
const path = require("path");
const fs = require("fs");
const fetch = require('node-fetch');
const currentWorkingDirectory = process.cwd();
const configPath = path.join(currentWorkingDirectory, '../config', 'user-config.json')
const myConfig = JSON.parse(fs.readFileSync(configPath, 'utf8'));
const cookieParser  = require('cookie-parser');
const session = require('express-session');

const appShared = require('./app/app-shared');
const libShared = require('./lib/lib-shared');

const prodCat = require('./app/product/app-prod-category');
const modifier = require('./app/product/app-prod-modifier')
const store = require('./app/settings/app-setting-store');
const receiptTemp = require('./app/settings/app-setting-receipt-temp');
const tax = require('./app/settings/app-setting-tax');
const prod = require('./app/product/app-prod-setup');
const meal = require('./app/settings/app-setting-meal-period');
const pymt = require('./app/settings/app-setting-pymt-mode');
const table = require('./app/settings/app-setting-table');
const tableSec = require('./app/settings/app-setting-table-sec');
const posStation = require('./app/settings/app-pos-station');
const posPrinter = require('./app/settings/app-pos-printer');
const customer = require('./app/app-customer');
// const supplier = require('./app/app-supplier');
const generalSet = require('./app/settings/app-setting-general');
const cashier = require('./app/cashiering/app-cashiering-shift');
const usergrp = require('./app/user/app-user-group');
const user = require('./app/user/app-users');
const rpt = require('./app/report/app-report');
const mail = require('./app/app-mail-service');
const other = require('./app/other/app-other');
const uac = require('./app/app-user-access');

// Order process
const order = require('./app/order/app-order-trans');

const auth = require('./middleware/auth')

// Session
// async function secret() { await appShared.getSession(); } 
// async function sessionTime() { libShared.toInt(await appShared.getSessTime()); }

app.use(cors());
app.use(express.json());

app.use(cookieParser());                       // Cookie parser to read cookies
app.use(session({
    secret: '2fe1995696894399fe39ecad33cf09b9d8367bb3154b755bf7d2041d4124b156091005dcd1ec22c3f2b0d723df3522a5bf359d08f5e9df0ba2b4c09eb5df20b3',                            // Secret key for encrypting session data will randomly generate 
    resave: false,                             // Do not save session if it was not modified
    saveUninitialized: true,                   // Save session even if it is new
    cookie: { 
        httpOnly: true,                        // Prevent client-side access to the cookie
        maxAge: 24 * 60 * 60 * 1000   // 1 day expiration for the session
    }
}));

// Serve static files from the 'product-file' directory
app.use('/il', express.static(path.join(__dirname, '..', 'product-file')));
app.use('/sl', express.static(path.join(__dirname, '..', 'user-file')));

app.use('/prodCat', prodCat);
app.use('/mod', modifier);
app.use('/store', store);
app.use('/receiptTemp', receiptTemp);
app.use('/tax', tax);
app.use('/prod', prod);
app.use('/mp', meal);
app.use('/pm', pymt);
app.use('/ts', tableSec);
app.use('/t', table);
app.use('/cus', customer);
app.use('/ps', posStation);
app.use('/pp', posPrinter);
// app.use('/spl', supplier);
app.use('/gs', generalSet);
app.use('/ug', usergrp);
app.use('/u', user);
app.use('/rpt', rpt);
app.use('/m', mail);
app.use('/oth', other);

app.use('/ord', order);
app.use('/csh', cashier);
app.use('/uac', uac);

// A scheduler

app.listen(myConfig.PORT, () => {
    console.log(`Server running on PORT: ${myConfig.PORT}`);
});