const express = require('express');

const app =express();

const UserRoutes = require('../routes/userRoutes');
const CenterRoutes = require('../routes/centerRoutes');

app.use(express.json());
app.use('/users', UserRoutes);
app.use('/centers', CenterRoutes);

app.get('/',(req,res)=>
{
    res.send('Hello World');
})


module.exports=app;