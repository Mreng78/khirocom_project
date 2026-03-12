require("dotenv").config()

const app=require('./src/config/app')
const sequelize=require('./src/config/database')

require ('./src/models/User');
require ('./src/models/Center');
require ('./src/models/Halakat');
require ('./src/models/Student');
require ('./src/models/StudentPlane');
require ('./src/models/StudentPlane');

const port=process.env.PORT || 8000;


async function startServer()
{
    try{
        await sequelize.authenticate();
        console.log('Database connected');

        await sequelize.sync({alter:true});
        console.log('Database synced');


        app.listen(port,()=>
        {
            console.log(`The server is listening on port ${port}`);
        })

    }
    catch(error)
    {
        console.error(error);
    }
}

startServer();