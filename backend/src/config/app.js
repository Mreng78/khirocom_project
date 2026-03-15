const express = require('express');

const app =express();

const UserRoutes = require('../routes/userRoutes');

app.use(express.json());
app.use('/api/users', UserRoutes);

app.get('/',(req,res)=>
{
    res.send('Hello World');
})


module.exports=app;