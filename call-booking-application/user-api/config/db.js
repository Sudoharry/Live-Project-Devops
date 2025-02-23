const mongoose = require('mongoose');

const connectDB = async () => {
    try {
       await  mongoose.connect(process.env.MONGO_URL, {
           useNewUrlParser: true,
           useUnifiedTopology: true,
        });

         console.log ('connected to MongoDB')
    } catch (error) {
        console.error(`MongoDB connection Error: ${error.message}`);
        process.exit();
    }
};

module.exports = connectDB;
