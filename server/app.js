const express = require('express');
const app = express();
const cors = require('cors');
const userConfig = require('./config/user-config');
const prodCat = require('./app/app-prod-category');
const store = require('./app/app-setting-store');
const receiptTemp = require('./app/app-setting-receipt-temp');

app.use(cors());
app.use(express.json());

app.use('/prodCat', prodCat);
app.use('/store', store);
app.use('/receiptTemp', receiptTemp);

app.listen(userConfig.PORT, () => {
    console.log(`Server running on PORT: ${userConfig.PORT}`);
});