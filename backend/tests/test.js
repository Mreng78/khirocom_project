// tests/test-upload.js
const upload = require('../src/middleware/uploads');

console.log('Upload middleware loaded successfully!');
console.log('Available methods:');
console.log('  - upload.single(\'image\') - for single file upload');
console.log('  - upload.array(\'images\', 5) - for multiple files');