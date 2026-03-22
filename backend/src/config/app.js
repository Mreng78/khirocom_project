const express = require('express');

const app =express();

const UserRoutes = require('../routes/userRoutes');
const CenterRoutes = require('../routes/centerRoutes');
const HalakatRoutes = require('../routes/halaqatRouts');
const AreaRoutes = require('../routes/areaRouts');

app.use(express.json());
app.use('/users', UserRoutes);
app.use('/centers', CenterRoutes);
app.use('/halaqat', HalakatRoutes);
app.use('/areas', AreaRoutes);

app.get('/',(req,res)=>
{
    res.send('Hello World');
})


module.exports=app;