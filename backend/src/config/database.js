require ("dotenv").config();
const {Sequelize} = require('sequelize');

console.log("Database Configuration:");
console.log("DB_HOST:", process.env.DB_HOST);
console.log("DB_PORT:", process.env.DB_PORT);
console.log("DB_USER:", process.env.DB_USER);
console.log("DB_NAME:", process.env.DB_NAME);

const sequelize =new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    process.env.DB_PASSWORD,
    {
        host:process.env.DB_HOST,
        port:process.env.DB_PORT || 3306,
        
        dialect:'mysql',
        logging:false,
        dialectOptions: {
            connectTimeout: 10000,
        },
    }
)
module.exports = sequelize;