require("dotenv").config()

const app=require('./src/config/app')
const sequelize=require('./src/config/database')


const port=process.env.PORT || 8000;


async function startServer()
{
    try{
        await sequelize.authenticate();
        console.log('Database connected');

        await sequelize.sync({alter:true});

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