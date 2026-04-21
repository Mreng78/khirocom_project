const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());

const UserRoutes = require('../routes/userRoutes');
const CenterRoutes = require('../routes/centerRoutes');
const HalakatRoutes = require('../routes/halaqatRouts');
const AreaRoutes = require('../routes/areaRouts');
const StudentRoutes = require('../routes/studentRouts');
const DailyProgressRoutes = require('../routes/DailyProgressRouts');
const StudentsPlanRoutes = require('../routes/StudentsPlanRouts');
const MentorVisitRoutes = require('../routes/MentorVisitRouts');
const ActivityRoutes = require('../routes/activityRouts');
const MonthlyRateRoutes = require('../routes/MonthlyRateRouts');
const NotificationRoutes = require('../routes/NotificationRouts');
const GraduateRoutes = require('../routes/GraduateRouts');
const UploadRoutes = require('../routes/uploadRoutes');


app.use(express.json());
app.use('/api/users', UserRoutes);
app.use('/api/centers', CenterRoutes);
app.use('/api/halaqat', HalakatRoutes);
app.use('/api/areas', AreaRoutes);
app.use('/api/students', StudentRoutes);
app.use('/api/dailyprogress', DailyProgressRoutes);
app.use('/api/studentplan', StudentsPlanRoutes);
app.use('/api/mentorvisit', MentorVisitRoutes);
app.use('/api/monthlyrate', MonthlyRateRoutes);
app.use('/api/notification', NotificationRoutes);
app.use('/api/activity', ActivityRoutes);
app.use('/api/graduate', GraduateRoutes);
app.use('/api/uploads', UploadRoutes);


app.use('/uploads', express.static('uploads'));

app.get('/',(req,res)=>
{
    res.send('Hello World');
})




module.exports=app;