const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');

// Configure multer storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Save to backend/uploads folder
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

// Upload route
router.post('/upload', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ success: false, message: 'لم يتم اختيار ملف' });
  }

  // Generate the URL for the uploaded file
  // Note: Replace with your server's IP if not running locally
  const imageUrl = `http://192.168.0.3:8000/uploads/${req.file.filename}`;
  
  res.status(200).json({
    success: true,
    message: 'تم رفع الملف بنجاح',
    imageUrl: imageUrl,
    filename: req.file.filename
  });
});

module.exports = router;
