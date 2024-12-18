const path = require('path');
const fs = require('fs');
const ipp = require('ipp');         // For printer

const { pgSql } = require('../../lib/lib-pgsql');
const libShared = require('../../lib/lib-shared');

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('.js', '');

// Replace with your printer's IPP URL
const printerUrl = 'http://printer-ip:631/ipp/print';

// Create the printer object
const printer = ipp.Printer(printerUrl);

// The document content you want to print (simple text)
const document = "Order for Kitchen\n1 x Cheeseburger\n1 x Fries\n";

// Prepare the print job message
const msg = {
  "operation-attributes-tag": {
    "requesting-user-name": "nodejs-user", // Optional user info
    "job-name": "Kitchen Order",            // Print job name
    "document-format": "text/plain"         // Document format
  },
  "data": Buffer.from(document)  // Convert the document content to a Buffer
};

// Send the print job to the printer
printer.execute("Get-Jobs", msg, (err, res) => {
    console.log(res);
    
    if (err) {
      console.error("Error sending print job:", err);
    } else {
    console.log(msg);
    
      console.log("Print job sent successfully!");
      console.log("Response:", res); // Printer response (e.g., job ID, status)
  
      // Check if the response contains job-id (it should for a successful print job)
      if (res && res['operation-attributes-tag'] && res['operation-attributes-tag']['job-id']) {
        console.log("Job ID:", res['operation-attributes-tag']['job-id']);
      } else {
        console.log("No job ID received in the response.");
      }
    }
  });

  module.exports = {

  };
