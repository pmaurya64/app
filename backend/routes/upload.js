const express = require('express');
const multer = require('multer');
const db = require('../db');
const authenticateToken = require('../middleware/authMiddleware');
const path = require('path');

const router = express.Router();

const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: (req, file, cb) => {
    const unique = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, unique + path.extname(file.originalname));
  }
});
const upload = multer({ storage });

router.post('/', authenticateToken, upload.single('document'), (req, res) => {
  const { user } = req;
  const { filename, originalname } = req.file;

  db.run(
    'INSERT INTO uploads (user_id, filename, originalname) VALUES (?, ?, ?)',
    [user.id, filename, originalname],
    function(err) {
      if (err) return res.status(500).json({ message: 'DB error' });
      res.json({ message: 'File uploaded', file: filename });
    }
  );
});

module.exports = router;

