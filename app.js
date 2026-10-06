const express = require('express');
const cors = require('cors');
const apiRoutes = require('./routes');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

// Attach API Routes
app.use('/api', apiRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Backend server running on http://localhost:${PORT}`);
});