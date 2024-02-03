// routes/index.js
const express = require('express');
const router = express.Router();
const db = require('../database/db');
const bodyParser = require('body-parser');

router.use(bodyParser.json());

router.get('/', (req, res) => {
  res.render('login');
});

// Login route
router.post('/login', async (req, res) => {
  const { regNumber, password } = req.body;

  try {
    // Check in the supervisor table
    const supervisorResult = await db.query('SELECT * FROM supervisors WHERE Su_email = ? AND Su_password = ?', [regNumber, password]);

    const supervisors = supervisorResult[0];

    if (supervisors.length > 0) {
      const supervisor = supervisors[0];
      // Assign the supervisor's email to the session
      req.session.supervisorId = supervisor.id;
      res.redirect('/dashboard1');
    } else {
      // If not found in supervisor table, check in the student table
      const studentsResult = await db.query('SELECT * FROM students WHERE s_regno = ? AND s_password = ?', [regNumber, password]);

      const students = studentsResult[0];

      if (students.length > 0) {
        const student = students[0];
        // Assign the registration number to the session
        req.session.stuId = student.id;
        res.redirect('/dashboard2');
      } else {
        req.session.errorMessage = 'Invalid credentials. Please try again.';
        console.log('Invalid credentials. Redirecting to login...');
        res.redirect('/');
      }
    }
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
});

// Dashboard route for supervisors
router.get('/dashboard1', (req, res) => {
  if (!req.session.supervisorId) {
    return res.redirect('/');
  }

  res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
  res.header('Expires', '-1');
  res.header('Pragma', 'no-cache');

  res.render('dashboard1', { supervisorId: req.session.supervisorId });
});

// Dashboard route for students
router.get('/dashboard2', async (req, res) => {
  console.log('Session in dashboard2:', req.session);

  if (!req.session.stuId) {
    return res.redirect('/');
  }

  try {
    const studentId = req.session.stuId;
    const reportsCount = await getReportsCount(studentId);

    // Get assessed reports count
    const assessedReportsCount = await getAssessedReportsCount(studentId);

    res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
    res.header('Expires', '-1');
    res.header('Pragma', 'no-cache');

    res.render('dashboard2', { regNumber: req.session.stuId, reportsCount, assessedReportsCount });
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
});

// Make the getReportsCount function async
async function getReportsCount(studentId) {
  try {
    // Implement logic to fetch the count from your database
    const result = await db.query('SELECT COUNT(*) AS reports_count FROM reportweeks WHERE student_id = ?', [studentId]);

    if (result[0].length > 0) {
      return result[0][0].reports_count;
    } else {
      return 0; // Return 0 if no reports found
    }
  } catch (error) {
    console.error(error);
    throw error; // Handle the error appropriately in your application
  }
}

// Assume getAssessedReportsCount is a similar function for assessed reports
async function getAssessedReportsCount(studentId) {
  try {
    // Implement logic to fetch the assessed reports count from your database
    const result = await db.query(`
      SELECT COUNT(*) AS assessed_reports_count
      FROM students
      JOIN reportweeks ON students.id = reportweeks.student_id
      JOIN assessments ON reportweeks.id = assessments.report_id
      JOIN supervisors ON assessments.supervisor_id = supervisors.id
      WHERE students.id = ? AND assessments.status = 'ASSESSED';
    `, [studentId]);

    if (result[0].length > 0) {
      return result[0][0].assessed_reports_count;
    } else {
      return 0; // Return 0 if no assessed reports found
    }
  } catch (error) {
    console.error(error);
    throw error; // Handle the error appropriately in your application
  }
}


async function getAssessedReportsCount(studentId) {
  try {
    // Implement logic to fetch the count from your database
    const result = await db.query(`
      SELECT COUNT(*) AS assessed_reports_count
      FROM students
      JOIN reportweeks ON students.id = reportweeks.student_id
      JOIN assesments ON reportweeks.id = assesments.report_id
      JOIN supervisors ON assesments.supervisor_id = supervisors.id
      WHERE students.id=?;
    `, [studentId]);

    if (result[0].length > 0) {
      return result[0][0].assessed_reports_count;

    } else {
      return 0; // Return 0 if no assessed reports found
    }
  } catch (error) {
    console.error(error);
    throw error; // Handle the error appropriately in your application
  }
}


router.post('/submitReport', async (req, res) => {
  try {
    const { Monday, Tuesday, Wednesday, Thursday, Friday, link } = req.body;

    const studentId = req.session.stuId;

    const result = await db.query(`
      INSERT INTO reportweeks (student_id, monday_report, tuesday_report, wednesday_report, thursday_report, friday_report, cloud_link)
      VALUES (?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE
      student_id = VALUES(student_id),
      monday_report = VALUES(monday_report),
      tuesday_report = VALUES(tuesday_report),
      wednesday_report = VALUES(wednesday_report),
      thursday_report = VALUES(thursday_report),
      friday_report = VALUES(friday_report),
      cloud_link = VALUES(cloud_link)`,
      [studentId, Monday, Tuesday, Wednesday, Thursday, Friday, link]);

    if (result.affectedRows > 0) {
      res.status(200).send({ message: 'Report submitted successfully!' });
    } else {
      res.status(500).send({ error: 'Failed to submit report. Please try again.' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

router.get('/edit', (req, res) => {
  res.render('edit');
});

router.get('/add-student', (req, res) => {
  res.render('add-student');
});



// Logout route
router.get('/logout', (req, res) => {
  // Destroy the session to log the user out
  req.session.destroy((err) => {
    if (err) {
      console.error(err);
      res.status(500).send('Internal Server Error');
    } else {
      res.redirect('/');
    }
  });
});



module.exports = router;

