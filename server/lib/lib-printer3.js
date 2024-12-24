const http = require('http');
const fs = require('fs');
const path = require('path');

const printerUrl = 'http://192.168.14.63'; // Replace with your printer's URL

const libPrinter = {};

// Function to send a print job
libPrinter.printJob = (pdfBuffer, jobName, callback) => {
  const options = {
    hostname: new URL(printerUrl).hostname,
    port: new URL(printerUrl).port || 631,
    path: new URL(printerUrl).pathname,
    method: 'POST',
    headers: {
      'Content-Type': 'application/pdf',
      'Job-Name': jobName,
    },
  };

  const req = http.request(options, (res) => {
    let data = '';
    res.on('data', (chunk) => {
      data += chunk;
    });

    res.on('end', () => {
      const jobIdMatch = data.match(/job-id="(\d+)"/); // Adjust regex based on response
      const jobId = jobIdMatch ? parseInt(jobIdMatch[1], 10) : null;

      if (res.statusCode === 200 && jobId) {
        callback(null, { jobId, response: data });
      } else {
        callback(new Error('Failed to print job or job ID not found'), null);
      }
    });
  });

  req.on('error', (err) => {
    callback(err, null);
  });

  req.write(pdfBuffer);
  req.end();
};

// Function to get job attributes
libPrinter.getJobAttributes = (jobId, callback) => {
  const options = {
    hostname: new URL(printerUrl).hostname,
    port: new URL(printerUrl).port || 631,
    path: `/jobs/${jobId}`, // Replace with the correct IPP endpoint for your printer
    method: 'GET',
  };

  const req = http.request(options, (res) => {
    let data = '';
    res.on('data', (chunk) => {
      data += chunk;
    });

    res.on('end', () => {
      if (res.statusCode === 200) {
        callback(null, data); // Return raw attributes data
      } else {
        callback(new Error(`Failed to fetch job attributes, status code: ${res.statusCode}`), null);
      }
    });
  });

  req.on('error', (err) => {
    callback(err, null);
  });

  req.end();
};

const pdfPath = path.join(__dirname, '../../temp/invoice2.pdf'); // Path to your PDF file
const jobName = "Test Print Job";

fs.readFile(pdfPath, (err, pdfBuffer) => {
  if (err) {
    console.error("Failed to read PDF file:", err);
    return;
  }

  libPrinter.printJob(pdfBuffer, jobName, (err, result) => {
    if (err) {
      console.error("Failed to send print job:", err);
    } else {
      console.log("Print job sent successfully:", result);

      // Use the job ID for further operations
      const jobId = result.jobId;
      console.log("Job ID:", jobId);

      libPrinter.getJobAttributes(jobId, (err, jobAttributes) => {
        if (err) {
          console.error("Failed to get job attributes:", err);
        } else {
          console.log("Job Attributes:", jobAttributes);
        }
      });
    }
  });
});

module.exports = libPrinter;
