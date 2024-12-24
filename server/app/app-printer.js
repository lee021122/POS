// // const path = require('path');
// // const fs = require('fs');
// // const ipp = require('ipp'); // For printer
// // // const os = require('os');
// // // const networkInterfaces = os.networkInterfaces();
// // // console.log(networkInterfaces); // Inspect active interfaces to find your subnet
// // const { PDFDocument, StandardFonts } = require('pdf-lib');

// // async function createReceiptPDF(documentText, outputFilePath) {
// //   // Create a new PDF document
// //   const pdfDoc = await PDFDocument.create();

// //   // Embed the font for the PDF
// //   const font = await pdfDoc.embedFont(StandardFonts.Helvetica);

// //   // Define receipt dimensions (width x height in points)
// //   const receiptWidth = 200; // ~2.7 inches
// //   const receiptHeight = 600; // Adjust based on content length
// //   let currentPage = pdfDoc.addPage([receiptWidth, receiptHeight]);

// //   // Set font size and margins
// //   const fontSize = 10;
// //   const margin = 10;

// //   // Calculate the usable width for text
// //   const textWidth = receiptWidth - margin * 2;

// //   // Split the text into lines that fit within the width
// //   const lines = font
// //     .splitTextIntoLines(documentText, fontSize, textWidth)
// //     .map((line) => line.text);

// //   // Starting Y position for the text
// //   let y = receiptHeight - margin;

// //   // Draw the text, adding pages as needed
// //   for (const line of lines) {
// //     if (y < margin) {
// //       // Add a new page if we run out of space
// //       currentPage = pdfDoc.addPage([receiptWidth, receiptHeight]);
// //       y = receiptHeight - margin;
// //     }

// //     currentPage.drawText(line, {
// //       x: margin,
// //       y,
// //       size: fontSize,
// //       font,
// //     });

// //     y -= fontSize + 4; // Line height
// //   }

// //   // Save the PDF and write it to a file
// //   const pdfBytes = await pdfDoc.save();
// //   fs.writeFileSync(outputFilePath, pdfBytes);
// //   console.log(`Receipt PDF created at: ${outputFilePath}`);
// // }

// // // Your receipt content
// const PDFDocument = require('pdfkit');

const libRpt = require('../lib/lib-rpt')
const fs = require('fs');
const path = require('path');
const currentWorkingDirectory = process.cwd();

const tempDir = path.join(currentWorkingDirectory, '../', 'temp');
console.log(tempDir);


// // Create the directory if it doesn't exist
// try {
//     if (!fs.existsSync(tempDir)) {
//         console.log("Directory does not exist, creating...");

//         // Create the directory recursively (including any parent directories if needed)
//         fs.mkdirSync(tempDir, { recursive: true });
//         console.log("Directory created successfully");
//     } else {
//         console.log("Directory already exists.");
//     }
// } catch (error) {
//     // Log error if directory creation fails
//     console.error("Error creating directory:", error);
// };

// // Define receipt paper size: 80mm wide (227 points), height is variable
// const paperWidth = 227; // 80mm in points
// const paperHeight = 9999; // Use a large height to allow dynamic content

// // Create a new PDF document
// const doc = new PDFDocument({
//   size: [paperWidth, paperHeight],
//   margins: { top: 10, left: 10, right: 10, bottom: 10 } // Adjust margins as needed
// });

// doc.pipe(fs.createWriteStream('receipt.pdf'));
const opt = {
    paperSize: 'A8', // Custom receipt paper size
    pageLayout: 'portrait',
};

const file_name = 'invoice.pdf';

const pdf_info = {
    Title: 'Invoice',
    Author: 'Your Company',
    Subject: 'Customer Invoice',
};

const doc = libRpt.newPdf(opt, file_name, pdf_info);

// Add content to the document
doc.fontSize(16).text('Invoice', { align: 'center' });
doc.fontSize(12).text('Customer Name: John Doe', { align: 'left' });
doc.text('----------------------------------------');
doc.text('Item                 Qty         Price');
doc.text('----------------------------------------');
doc.text('Apple               2           $3.00');
doc.text('Orange              1           $1.50');
doc.text('----------------------------------------');
doc.text('Total:                        $4.50', { align: 'right' });

// Finalize the document
doc.end();


// // Example receipt content
// doc.text('ABC Store', { align: 'center' });
// doc.text('Registration No: 1518739-K', { align: 'center' });
// doc.text('Wisma Noble Land 2 Lorong Changkat', { align: 'center' });
// doc.text('Lorong Ceylon, 50200, Kuala Lumpur', { align: 'center' });
// doc.text('Malaysia', { align: 'center' });
// doc.text('011-99999999', { align: 'center' });
// doc.text('abc@abc.com\n', { align: 'center' });

// doc.text('----------------------------------------', { align: 'center' });
// doc.text('Invoice No: TS2024121600001');
// doc.text('Pax: 2');
// doc.text('Table No: T-04');
// doc.text('Room No: -');
// doc.text('Cashier: tester');
// doc.text('Date: 2024-12-16 12:02:59.6768');
// doc.text('----------------------------------------');

// doc.text(' Qty Item                      Amt      ');
// doc.text('----------------------------------------');
// doc.text('   1 Nasi Goreng Biasa         8.00     ');
// doc.text('   1 Nasi Goreng Pattaya       13.00    ');
// doc.text('----------------------------------------');

// // Finalize the PDF and end the stream
// doc.end();

// const PDFDocument = require('pdfkit');
// const fs = require('fs');

// // Define receipt paper width (80mm = 227 points)
// const paperWidth = 227; // 80mm in points

// // Placeholder to calculate required height
// let currentHeight = 10; // Start with a top margin

// // Function to simulate adding text and calculate height
// const calculateTextHeight = (doc, text, options = {}) => {
//   const lineHeight = doc.heightOfString(text, options);
//   return lineHeight + (options.spacing || 0); // Add any custom spacing
// };

// // Prepare the content
// const lines = [
//   'ABC Store',
//   'Registration No: 1518739-K',
//   'Wisma Noble Land 2 Lorong Changkat',
//   'Lorong Ceylon, 50200, Kuala Lumpur',
//   'Malaysia',
//   '011-99999999',
//   'abc@abc.com',
//   '----------------------------------------',
//   'Invoice No: TS2024121600001',
//   'Pax: 2',
//   'Table No: T-04',
//   'Room No: -',
//   'Cashier: tester',
//   'Date: 2024-12-16 12:02:59.6768',
//   '----------------------------------------',
//   ' Qty Item                      Amt      ',
//   '----------------------------------------',
//   '   1 Nasi Goreng Biasa         8.00     ',
//   '   1 Nasi Goreng Pattaya       13.00    ',
//   '----------------------------------------',
// ];

// // Simulate calculating the height required
// const fontSize = 12; // Example font size
// lines.forEach((line) => {
//   currentHeight += calculateTextHeight(new PDFDocument({ size: [paperWidth, 9999] }), line, {
//     width: paperWidth - 20,
//     align: 'left',
//     spacing: 2,
//   });
// });

// // Create the PDF document with calculated height
// const doc = new PDFDocument({
//   size: [paperWidth, currentHeight],
//   margins: { top: 10, left: 10, right: 10, bottom: 10 },
// });

// doc.pipe(fs.createWriteStream('dynamic-receipt.pdf'));

// // Render the content into the PDF
// lines.forEach((line) => {
//   doc.text(line, { width: paperWidth - 20, align: 'left' });
// });

// // Finalize the PDF
// doc.end();




// // // Output file path
// // const outputFilePath = './receipt.pdf';

// // // Generate the receipt-sized PDF
// // createReceiptPDF(documentText, outputFilePath).catch((err) =>
// //   console.error('Error creating receipt PDF:', err)
// // );


// // // Replace with your printer's IPP URL
// // const printerUrl = 'http://192.168.14.63';

// // // Create the printer object
// // const printer = ipp.Printer(printerUrl);

// // // The document content you want to print (simple text)
// //   // const document = `
// //   // ABC Store
// //   // Registration No: 1518739-K
// //   // Wisma Noble Land 2 Lorong Changkat, 
// //   // Lorong Ceylon, 
// //   // 50200, Kuala Lumpur, 
// //   // Malaysia
// //   // 011-99999999
// //   // abc@abc.com

// //   // ----------------------------------------
// //   // Invoice No: TS2024121600001
// //   // Pax: 2
// //   // Table No: T-04
// //   // Room No: -
// //   // Cashier: tester
// //   // Date: 2024-12-16 12:02:59.6768
// //   // ----------------------------------------
// //   // Qty Item                      Amt      
// //   // ----------------------------------------
// //   //   1 Nasi Goreng Biasa         8.00     
// //   //   1 Nasi Goreng Pattaya       13.00    
// //   // ----------------------------------------
// //   // `;
// // // Function to check printer attributes
// // function getPrinterAttributes(printer) {
// //   printer.execute("Get-Printer-Attributes", null, (err, res) => {
// //     if (err) {
// //       console.error("Error fetching printer attributes:", err);
// //     } else {
// //       const attributes = res['printer-attributes-tag'];
// //       console.log("Supported document formats:", attributes['document-format-supported']);
// //       console.log("Printer state:", attributes['printer-state']);
// //       console.log("Printer state reasons:", attributes['printer-state-reasons']);
// //     }
// //   });
// // }

// // // Function to send the print job
// // function sendPrintJob(printer, documentContent) {
// //   // Prepare the print job message
// //   const msg = {
// //     "operation-attributes-tag": {
// //       "requesting-user-name": "nodejs-user", // Optional user info
// //       "job-name": "Kitchen Order",          // Print job name
// //       "document-format": "text/plain"       // Document format (plain text for this example)
// //     },
// //     "data": Buffer.from(documentContent, 'utf-8') // Convert the document content to a Buffer
// //   };

// //   printer.execute("Print-Job", msg, (err, res) => {
// //     if (err) {
// //       console.error("Error sending print job:", err);
// //     } else {
// //       console.log("Print job sent successfully!");
// //       console.log("Response:", res);

// //       // Check job attributes in the response
// //       if (res && res['job-attributes-tag']) {
// //         const jobId = res['job-attributes-tag']['job-id'];
// //         const jobState = res['job-attributes-tag']['job-state'];
// //         const jobStateReasons = res['job-attributes-tag']['job-state-reasons'];

// //         console.log("Job ID:", jobId);
// //         console.log("Job State:", jobState);
// //         console.log("Job State Reasons:", jobStateReasons);
// //       } else {
// //         console.log("No job attributes in the response.");
// //       }
// //     }
// //   });
// // }

// // // Fetch printer attributes
// // getPrinterAttributes(printer);

// // // Send the print job
// // sendPrintJob(printer, document);

// // // Prepare the print job message
// // // const msg = {
// // //   "operation-attributes-tag": {
// // //     "requesting-user-name": "nodejs-user", // Optional user info
// // //     "job-name": "Kitchen Order",          // Print job name
// // //     "document-format": "application/pdf"     // Document format (plain text)
// // //   },
// // //   "data": Buffer.from(document, 'utf-8')  // Convert the document content to a Buffer
// // // };

// // // printer.execute("Get-Printer-Attributes", null, (err, res) => {
// // //   if (err) {
// // //     console.error("Error fetching printer attributes:", err);
// // //   } else {
// // //     console.log("Supported formats:", res['printer-attributes-tag']['document-format-supported']);
// // //   }
// // // });


// // // // Send the print job to the printer
// // // printer.execute("Print-Job", msg, (err, res) => {
// // //   if (err) {
// // //     console.error("Error sending print job:", err);
// // //   } else {
// // //     console.log("Print job sent successfully!");
// // //     console.log("Response:", res); // Printer response (e.g., job ID, status)

// // //     // Check if the response contains job-id (it should for a successful print job)
// // //     if (res && res['job-attributes-tag'] && res['job-attributes-tag']['job-id']) {
// // //       console.log("Job ID:", res['job-attributes-tag']['job-id']);
// // //     } else {
// // //       console.log("No job ID received in the response.");
// // //     }
// // //   }
// // // });
// // // const os = require('os');
// // // const ipp = require('ipp');
// // // const ipp = require('ipp');
// // // const ping = require('net-ping');

// // /**
// //  * Get the network base from the active network interface.
// //  */
// // // function getNetworkBase() {
// // //   const networkInterfaces = os.networkInterfaces();
// // //   for (const interfaceName in networkInterfaces) {
// // //     for (const iface of networkInterfaces[interfaceName]) {
// // //       console.log(iface);
      
// // //       // Look for IPv4, non-internal (non-loopback) addresses
// // //       if (iface.family === 'IPv4' && !iface.internal) {
// // //         const ipParts = iface.address.split('.');
// // //         console.log(ipParts);
        
// // //         ipParts.pop(); // Remove the last segment to get the base
// // //         return ipParts.join('.');
// // //       }
// // //     }
// // //   }
// // //   throw new Error("No active network interface found.");
// // // }

// // /**
// //  * Scan printers on the detected network base.
// //  */
// // // function scanPrinters(callback) {
// // //   const networkBase = getNetworkBase();
// // //   console.log(`Scanning network: ${networkBase}.x`);

// // //   const session = ping.createSession();
// // //   const printers = [];
// // //   const tasks = [];

// // //   for (let i = 1; i <= 254; i++) {
// // //     const ip = `${networkBase}.${i}`;
// // //     tasks.push(
// // //       new Promise((resolve) => {
// // //         session.pingHost(ip, (error) => {
// // //           if (!error) {
// // //             // If reachable, probe for IPP protocol
// // //             const printerUrl = `http://${ip}:631`;
// // //             const printer = ipp.Printer(printerUrl);

// // //             printer.execute("Get-Printer-Attributes", null, (err, res) => {
// // //               if (!err && res && res['printer-attributes-tag']) {
// // //                 printers.push({
// // //                   ip,
// // //                   name: res['printer-attributes-tag']['printer-name'] || 'Unknown Printer',
// // //                   uri: printerUrl,
// // //                 });
// // //               }
// // //               resolve();
// // //             });
// // //           } else {
// // //             resolve();
// // //           }
// // //         });
// // //       })
// // //     );
// // //   }

// // //   Promise.all(tasks).then(() => {
// // //     session.close();
// // //     callback(null, printers);1
// // //   });
// // // }

// // // function scanPrinters(callback) {
// // //   const networkBase = getNetworkBase();
// // //   console.log(`Scanning network: ${networkBase}.x`);

// // //   const session = ping.createSession();
// // //   const printers = [];
// // //   const concurrencyLimit = 100;  // Adjust this limit based on your network capacity
// // //   const tasks = [];
// // //   let activeTasks = 0;
// // //   let taskIndex = 1;

// // //   // Helper function to process tasks
// // //   function processNextTask() {
// // //     if (taskIndex > 254) return;  // All tasks have been queued

// // //     const ip = `${networkBase}.${taskIndex}`;
// // //     taskIndex++;
// // //     console.log(ip);
    
// // //     const task = new Promise((resolve) => {
// // //       session.pingHost(ip, (error) => {
// // //         if (!error) {
// // //           // If reachable, probe for IPP protocol
// // //           const printerUrl = `http://${ip}:631`;
// // //           const printer = ipp.Printer(printerUrl);

// // //           printer.execute("Get-Printer-Attributes", null, (err, res) => {
// // //             if (!err && res && res['printer-attributes-tag']) {
// // //               printers.push({
// // //                 ip,
// // //                 name: res['printer-attributes-tag']['printer-name'] || 'Unknown Printer',
// // //                 uri: printerUrl,
// // //               });
// // //             }
// // //             resolve();
// // //           });
// // //         } else {
// // //           resolve();
// // //         }
// // //       });
// // //     });

// // //     tasks.push(task);   

// // //     // If there is room for more concurrent tasks, run the next one
// // //     if (activeTasks < concurrencyLimit) {
// // //       activeTasks++;
// // //       task.then(() => {
// // //         activeTasks--;
// // //         processNextTask();  // Start the next task once the current one is finished
// // //       });
// // //     }
// // //   }1

// // //   // Start processing tasks
// // //   for (let i = 0; i < concurrencyLimit; i++) {
// // //     processNextTask();
// // //   }

// // //   // Wait for all tasks to complete
// // //   Promise.all(tasks).then(() => {
// // //     session.close();
// // //     callback(null, printers);
// // //   });
// // // }

// // // // Example usage:
// // // scanPrinters((err, printers) => {
// // //   if (err) {
// // //     console.error("Error scanning for printers:", err);
// // //   } else {
// // //     console.log("Discovered printers:", printers);
// // //   }
// // // });

// const path = require('path');
// const fs = require('fs');
// const ipp = require('ipp'); // For printer
// const { PDFDocument, StandardFonts } = require('pdf-lib');

// async function createReceiptPDF(documentText, outputFilePath) {
//   const pdfDoc = await PDFDocument.create();
//   const font = await pdfDoc.embedFont(StandardFonts.Helvetica);

//   const receiptWidth = 200; // ~2.7 inches
//   const receiptHeight = 600;
//   const fontSize = 10;
//   const margin = 10;

//   const textWidth = receiptWidth - margin * 2;
//   const currentPage = pdfDoc.addPage([receiptWidth, receiptHeight]);
//   const lines = wrapText(font, documentText, fontSize, textWidth);

//   let y = receiptHeight - margin;

//   for (const line of lines) {
//     if (y < margin) {
//       y = receiptHeight - margin;
//       currentPage = pdfDoc.addPage([receiptWidth, receiptHeight]);
//     }
//     currentPage.drawText(line, { x: margin, y, size: fontSize, font });
//     y -= fontSize + 4;
//   }

//   const pdfBytes = await pdfDoc.save();
//   fs.writeFileSync(outputFilePath, pdfBytes);
//   console.log(`Receipt PDF created at: ${outputFilePath}`);
// }

// function wrapText(font, text, fontSize, maxWidth) {
//   const words = text.split(/\s+/); // Split text into words
//   const lines = [];
//   let currentLine = "";

//   for (const word of words) {
//     const lineWithWord = currentLine ? `${currentLine} ${word}` : word;
//     const lineWidth = font.widthOfTextAtSize(lineWithWord, fontSize);

//     if (lineWidth <= maxWidth) {
//       currentLine = lineWithWord;
//     } else {
//       lines.push(currentLine);
//       currentLine = word;
//     }
//   }

//   if (currentLine) {
//     lines.push(currentLine);
//   }

//   return lines;
// }


// function getPrinterAttributes(printer, callback) {
//   printer.execute("Get-Printer-Attributes", null, (err, res) => {
//     if (err) {
//       console.error("Error fetching printer attributes:", err);
//       callback(err);
//     } else {
//       const attributes = res['printer-attributes-tag'];
//       console.log("Supported document formats:", attributes['document-format-supported']);
//       console.log("Printer state:", attributes['printer-state']);
//       console.log("Printer state reasons:", attributes['printer-state-reasons']);
//       callback(null, attributes);
//     }
//   });
// }

// function sendPrintJob(printer, documentContent) {
//   const msg = {
//     "operation-attributes-tag": {
//       "requesting-user-name": "nodejs-user",
//       "job-name": "Kitchen Order",
//       "document-format": "application/pdf",
//     },
//     "data": Buffer.from(documentContent, 'utf-8'),
//   };

//   printer.execute("Print-Job", msg, (err, res) => {
//     if (err) {
//       console.error("Error sending print job:", err);
//     } else {
//       console.log("Print job sent successfully!");
//       console.log("Response:", res);

//       if (res && res['job-attributes-tag']) {
//         const jobId = res['job-attributes-tag']['job-id'];
//         const jobState = res['job-attributes-tag']['job-state'];
//         const jobStateReasons = res['job-attributes-tag']['job-state-reasons'];

//         console.log("Job ID:", jobId);
//         console.log("Job State:", jobState);
//         console.log("Job State Reasons:", jobStateReasons);

//         // Add handling for specific states
//         if (jobState === 'processing' && jobStateReasons === 'job-printing') {
//           console.log("Job is currently processing and printing.");
//         } else {
//           console.log("Job is in a different state or reason:", jobState, jobStateReasons);
//         }
//       } else {
//         console.log("No job attributes in the response.");
//       }
//     }
//   });
// }


// async function main() {
//   const documentText = `
// ABC Store\n
// Registration No: 1518739-K\n
// Wisma Noble Land 2 Lorong Changkat, \n
// Lorong Ceylon, \n
// 50200, Kuala Lumpur, \n
// Malaysia\n
// 011-99999999\n
// abc@abc.com\n
// \n
// ----------------------------------------\n
// Invoice No: TS2024121600001\n
// Pax: 2\n
// Table No: T-04\n
// Room No: -\n
// Cashier: tester\n
// Date: 2024-12-16 12:02:59.6768\n
// ----------------------------------------\n
//  Qty Item                      Amt      \n
// ----------------------------------------\n
//    1 Nasi Goreng Biasa         8.00     \n
//    1 Nasi Goreng Pattaya       13.00    \n
// ----------------------------------------\n
// `;

//   const outputFilePath = './receipt.pdf';
//   const printerUrl = 'http://192.168.14.63';
//   const printer = ipp.Printer(printerUrl);

//   try {
//     // Step 1: Create the receipt PDF
//     await createReceiptPDF(documentText, outputFilePath);

//     // Step 2: Check printer attributes
//     getPrinterAttributes(printer, (err, attributes) => {
//       if (err) return;

//       // Step 3: Send the PDF to the printer
//       sendPrintJob(printer, outputFilePath);
//     });
//   } catch (err) {
//     console.error("Error:", err);
//   }
// }

// main();

// const ipp = require('ipp');
// const PDFDocument = require('pdfkit');
// const fs = require('fs');

// // Make a PDF document
// var doc = new PDFDocument({ margin: 0 });
// doc.text(".", 0, 780);

// // Save the PDF to a buffer
// const pdfBuffer = [];
// doc.on('data', chunk => pdfBuffer.push(chunk));
// doc.on('end', () => {
//   const pdf = Buffer.concat(pdfBuffer);

//   // Create the printer object
//   var printer = ipp.Printer("http://192.168.14.63/");

//   // Prepare the print job message
//   var msg = {
//     "operation-attributes-tag": {
//       "requesting-user-name": "William",
//       "job-name": "My Test Job",
//       "document-format": "application/pdf"
//     },
//     data: pdf
//   };

//   // Send the print job
//   try {
//     printer.execute("Print-Job", msg, function (err, res) {
//       if (err) {
//         console.error("Error:", err);
//       } else {
//         console.log("Print job response:", res);
//       }
//     });
//   } catch (err) {
//     console.error("Error in sending print job:", err);
//   }
  
// });

// // Finalize the PDF document
// doc.end();