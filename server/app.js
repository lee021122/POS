const express = require('express');
const app = express();
const cors = require('cors');
const userConfig = require('./config/user-config');
const prodCat = require('./app/app-prod-category');

app.use(cors());
app.use(express.json());

app.use('/api', prodCat);

app.listen(userConfig.PORT, () => {
    console.log(`Server running on PORT: ${userConfig.PORT}`);
});