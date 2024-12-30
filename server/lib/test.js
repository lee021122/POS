// // const path = require("path")
// // const fs = require('fs')
// // const libPrinter = require('./lib-printer1');

// // // Initialize the printer with a URL
// // const printerUrl = "http://192.168.14.2:5000"; // Update to your printer's URL
// // libPrinter.init(printerUrl);

// // // Fetch Printer Attributes
// // libPrinter.getPrinterAttributes((err, attributes) => {
// //   if (err) {
// //     console.error("Failed to get printer attributes:", err);
// //   } else {
// //     console.log("Printer Attributes:", attributes);
// //   }
// // });

// // // Send a Print Job
// // // const pdfPath = path.join(__dirname, '../../temp/invoice2.pdf'); // Path to your PDF file
// // // console.log(pdfPath);
// // const plainTextContent = "This is a test print for plain text.";
// // const textBuffer = Buffer.from(plainTextContent, "utf-8");

// // const jobName = "Test Print Job";

// // // fs.readFile(pdfPath, (err, textBuffer) => {
// // //     console.log(pdfBuffer);
    
// // //   if (err) {
// // //     console.error("Failed to read PDF file:", err);
// // //     return;
// // //   }

// //   libPrinter.printJob(textBuffer, jobName, (err, response) => {
// //     if (err) {
// //       console.error("Failed to send print job:", err);
// //     } else {
// //       console.log("Print job sent successfully:", response);
// //     }
// //   });
// // // });

// // // Validate a Print Job
// // libPrinter.validateJob(Buffer.from("Test data for validation"), "Validation Test", (err, response) => {
// //   if (err) {
// //     console.error("Failed to validate print job:", err);
// //   } else {
// //     console.log("Validation successful:", response);
// //   }
// // });

// const escpos = require('escpos');
// // install escpos-usb adapter module manually
// escpos.USB = require('escpos-usb');
// // Select the adapter based on your printer type
// const device  = new escpos.USB();
// // const device  = new escpos.Network('localhost');
// // const device  = new escpos.Serial('/dev/usb/lp0');

// const options = { encoding: "GB18030" /* default */ }
// // encoding is optional

// const printer = new escpos.Printer(device, options);

// device.open(function(error){
//   printer
//   .font('a')
//   .align('ct')
//   .style('bu')
//   .size(1, 1)
//   .text('The quick brown fox jumps over the lazy dog')
//   .text('敏捷的棕色狐狸跳过懒狗')
//   .barcode('1234567', 'EAN8')
//   .table(["One", "Two", "Three"])
//   .tableCustom(
//     [
//       { text:"Left", align:"LEFT", width:0.33, style: 'B' },
//       { text:"Center", align:"CENTER", width:0.33},
//       { text:"Right", align:"RIGHT", width:0.33 }
//     ],
//     { encoding: 'cp857', size: [1, 1] } // Optional
//   )
//   .qrimage('https://github.com/song940/node-escpos', function(err){
//     this.cut();
//     this.close();
//   });
// });