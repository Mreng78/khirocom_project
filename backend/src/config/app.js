const express = require('express');

const app =express();

const UserRoutes = require('../routes/userRoutes');
const CenterRoutes = require('../routes/centerRoutes');
const HalakatRoutes = require('../routes/halaqatRouts');
const AreaRoutes = require('../routes/areaRouts');
const StudentRoutes = require('../routes/studentRouts');
const DailyProgressRoutes = require('../routes/DailyProgressRouts');
const StudentsPlanRoutes = require('../routes/StudentsPlanRouts');
const MentorVisitRoutes = require('../routes/MentorVisitRouts');
const MonthlyRateRoutes = require('../routes/MonthlyRateRouts');


app.use(express.json());
app.use('/users', UserRoutes);
app.use('/centers', CenterRoutes);
app.use('/halaqat', HalakatRoutes);
app.use('/areas', AreaRoutes);
app.use('/students', StudentRoutes);
app.use('/dailyprogress', DailyProgressRoutes);
app.use('/studentsplan', StudentsPlanRoutes);
app.use('/mentorvisit', MentorVisitRoutes);
app.use('/monthlyrate', MonthlyRateRoutes);


app.get('/',(req,res)=>
{
    res.send('Hello World');
})


module.exports=app;