const express = require('express');
const multer = require('multer');

const app = express();
const upload = multer({ dest: 'uploads/' }); // Configure destination for uploaded files

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html'); // Serve the upload form
});

app.post('/upload', upload.single('myFile'), (req, res) => {
  if (req.file) {
    console.log('File uploaded successfully:', req.file.filename);
    res.send('File uploaded successfully!');
  } else {
    console.error('Error uploading file');
    res.status(500).send('Failed to upload file');
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server listening on port ${port}`));