require ("dotenv").config();
const {Sequelize} = require('sequelize');



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
            charset: 'utf8mb4',
        },
        define: {
            charset: 'utf8mb4',
            collate: 'utf8mb4_unicode_ci'
        }
    }
)
module.exports = sequelize;