// // Solution 1: lib-printer1.js used ipp
// const path = require('path');
// const fs = require('fs');
// const ipp = require('ipp'); // For printer
// const os = require('os');

// // Import library
// const libRpt = require('./lib-rpt');

// function libPrinter() {};

// let printer = null;

// // 1. Printer Management Actions
// // --> Get-Printer-Attributes: Retrieve information about the printer's capabilities and status (e.g., supported formats, resolution).
// // --> Pause-Printer: Pause the printer, stopping it from processing new jobs.
// // --> Resume-Printer: Resume a paused printer.
// // --> Cancel-All-Jobs: Cancel all pending jobs in the printer's queue.
// // --> Enable-Printer: Enable the printer to accept jobs.
// // --> Disable-Printer: Disable the printer from accepting jobs.

// // 2. Job Management Actions
// // --> Print-Job: Submit a print job with the document data included in the request.
// // --> Validate-Job: Validate a print job without actually submitting it. Useful for checking if the job will be accepted.
// // --> Cancel-Job: Cancel a specific print job.
// // --> Get-Job-Attributes: Retrieve details about a specific job, including its status, job name, and document format.
// // --> Get-Jobs: Retrieve a list of all jobs in the printer's queue, including completed, pending, and active jobs.
// // --> Hold-Job: Put a print job on hold.
// // --> Release-Job: Release a held job, allowing it to be printed.
// // --> Restart-Job: Restart a job that has failed or been paused.
// // --> Set-Job-Attributes: Modify attributes of an existing print job (e.g., priority, number of copies).

// // 3. Document Management Actions
// // --> Create-Job: Create a print job without immediately sending the document data.
// // --> Send-Document: Send document data to an existing print job created with Create-Job.
// // --> Send-URI: Submit a print job by providing a URI to the document instead of uploading the data directly.

// // 4. Subscription and Notification Actions
// // --> Create-Printer-Subscription: Set up a subscription to receive notifications about printer events.
// // --> Create-Job-Subscription: Set up a subscription to receive notifications about job events.
// // --> Get-Subscriptions: Retrieve information about existing subscriptions.
// // --> Cancel-Subscription: Cancel a subscription.
// // --> Get-Notifications: Fetch notifications for a subscription.

// // 5. Administrative Actions
// // --> Get-Printer-Supported-Values: Retrieve the set of values the printer supports for certain attributes (e.g., media sizes, resolutions).
// // --> Set-Printer-Attributes: Modify attributes of the printer (requires administrative privileges).
// // --> Reset-Printer: Reset the printer to its default state.

// // 6. Security and Identity Actions
// // --> Identify-Printer: Trigger a physical or visual signal (e.g., flashing LED) to help locate the printer.
// // --> Get-Printer-Security-Attributes: Retrieve the security capabilities of the printer (e.g., encryption, authentication methods).

// // 7. Resource Management Actions
// // --> Add-Document-Resources: Add resources (e.g., fonts, ICC profiles) for a specific document.
// // --> Remove-Document-Resources: Remove resources associated with a document.
// // --> Get-Resources: Retrieve a list of available printer resources.

// // 8. Other Specialized Actions
// // --> Print-URI: Submit a print job using a URI that points to the document to be printed.
// // --> Fetch-Document: Retrieve a document associated with a print job (if the printer supports storing jobs).
// // --> Close-Job: Close an open print job to signal that no more data will be sent.

// // /**
// //  * Fetches printer attributes.
// //  * @param {function} callback - The callback function to handle the response.
// //  */
// // libPrinter.getPrinterAttributes = function (printer, callback) {
// //     if (!printer) {
// //         return callback(new Error("Printer not initialized. Call libPrinter.init(printerUrl) first."));
// //     };

// //     try {
// //         printer.execute("Get-Printer-Attributes", null, (err, res) => {
// //             if (err) {
// //             console.error("Error fetching printer attributes:", err);
// //             callback(err);
// //             } else {
// //             const attributes = res['printer-attributes-tag'];
// //             console.log("Supported document formats:", attributes['document-format-supported']);
// //             console.log("Printer state:", attributes['printer-state']);
// //             console.log("Printer state reasons:", attributes['printer-state-reasons']);
// //             callback(null, attributes);
// //             }
// //         });
// //     } catch (err) {
// //         console.error("Error fetching printer attributes:", err);
// //         callback(err);
// //     };
// // };

// // /**
// //  * Sends a print job to the printer.
// //  * @param {Buffer} pdfBuffer - The PDF data as a buffer.
// //  * @param {string} jobName - The name of the print job.
// //  * @param {function} callback - The callback function to handle the response.
// //  */
// // libPrinter.sendPrintJob = function (pdfBuffer, jobName, callback) {
// //     if (!printer) {
// //       return callback(new Error("Printer not initialized. Call libPrinter.init(printerUrl) first."));
// //     };
    
// //     try {
// //       const msg = {
// //         "operation-attributes-tag": {
// //           "requesting-user-name": "Node.js User",
// //           "job-name": jobName || "Default Print Job",
// //           "document-format": "application/pdf",
// //         },
// //         data: pdfBuffer,
// //       };
  
// //       printer.execute("Print-Job", msg, (err, res) => {
// //         if (err) {
// //           console.error("Error sending print job:", err);
// //           return callback(err);
// //         }
// //         console.log("Print job response:", res);

// //         if (res && res['job-attributes-tag']) {
// //             const jobId = res['job-attributes-tag']['job-id'];
// //             const jobState = res['job-attributes-tag']['job-state'];
// //             const jobStateReasons = res['job-attributes-tag']['job-state-reasons'];
    
// //             console.log("Job ID:", jobId);
// //             console.log("Job State:", jobState);
// //             console.log("Job State Reasons:", jobStateReasons);
    
// //             // Add handling for specific states
// //             if (jobState === 'processing' && jobStateReasons === 'job-printing') {
// //               console.log("Job is currently processing and printing.");
// //             } else {
// //               console.log("Job is in a different state or reason:", jobState, jobStateReasons);
// //             }
// //         } else {
// //             console.log("No job attributes in the response.");
// //         }

// //         callback(null, res);
// //       });
// //     } catch (err) {
// //       console.error("Error sending print job:", err);
// //       callback(err);
// //     };
// // };

// /**
//  * Initializes the printer with the given URL.
//  * @param {string} printerUrl - The URL of the printer.
//  */
// libPrinter.init = function (printerUrl) {
//   if (!printerUrl) {
//     throw new Error("Printer URL must be provided during initialization.");
//   }
//   printer = ipp.Printer(printerUrl);
//   console.log(`Printer initialized at: ${printerUrl}`);
// };

// /**
//  * Executes an IPP operation on the printer.
//  * @param {string} operation - The IPP operation name.
//  * @param {object} [attributes=null] - Optional operation attributes.
//  * @param {function} callback - Callback to handle the response.
//  */
// libPrinter.executeOperation = function (operation, attributes = null, callback) {
//   if (!printer) {
//     return callback(new Error("Printer not initialized. Call libPrinter.init(printerUrl) first."));
//   }
//   try {
//     printer.execute(operation, attributes, (err, res) => {
//       if (err) {
//         console.error(`Error executing ${operation}:`, err);
//         return callback(err);
//       }
//       console.log(`${operation} response:`, res);
//       callback(null, res);
//     });
//   } catch (err) {
//     console.error(`Error executing ${operation}:`, err);
//     callback(err);
//   }
// };

// // Printer Management Actions
// /**
//  * Retrieves printer attributes.
//  * @param {function} callback - Callback to handle the response.
//  */
// libPrinter.getPrinterAttributes = function (callback) {
//   this.executeOperation("Get-Printer-Attributes", null, callback);
// };

// /**
//  * Pauses the printer.
//  * @param {function} callback - Callback to handle the response.
//  */
// libPrinter.pausePrinter = function (callback) {
//   this.executeOperation("Pause-Printer", { "operation-attributes-tag": {} }, callback);
// };

// /**
//  * Resumes the printer.
//  * @param {function} callback - Callback to handle the response.
//  */
// libPrinter.resumePrinter = function (callback) {
//   this.executeOperation("Resume-Printer", { "operation-attributes-tag": {} }, callback);
// };

// /**
//  * Cancels all jobs in the printer queue.
//  * @param {function} callback - Callback to handle the response.
//  */
// libPrinter.cancelAllJobs = function (callback) {
//   this.executeOperation("Purge-Jobs", { "operation-attributes-tag": {} }, callback);
// };

// /**
//  * Enables the printer to accept jobs.
//  * @param {function} callback - Callback to handle the response.
//  */
// libPrinter.enablePrinter = function (callback) {
//   this.executeOperation("Enable-Printer", { "operation-attributes-tag": {} }, callback);
// };

// /**
//  * Disables the printer from accepting jobs.
//  * @param {function} callback - Callback to handle the response.
//  */
// libPrinter.disablePrinter = function (callback) {
//   this.executeOperation("Disable-Printer", { "operation-attributes-tag": {} }, callback);
// };

// // Job Management Actions
// libPrinter.printJob = function (documentData, jobName, callback) {
//     const attributes = {
//       "operation-attributes-tag": {
//         "requesting-user-name": os.userInfo().username,
//         "job-name": jobName || "Default Print Job",
//         "document-format": "application/pdf",
//       },
//       data: documentData,
//     };
//     this.executeOperation("Print-Job", attributes, callback);
// };

// libPrinter.validateJob = function (documentData, jobName, callback) {
//     const attributes = {
//       "operation-attributes-tag": {
//         "requesting-user-name": os.userInfo().username,
//         "job-name": jobName || "Validate Job",
//         "document-format": "application/pdf",
//       },
//       data: documentData,
//     };
//     this.executeOperation("Validate-Job", attributes, callback);
// };
  
// libPrinter.cancelJob = function (jobId, callback) {
//     const attributes = {
//       "operation-attributes-tag": {
//         "job-id": jobId,
//       },
//     };
//     this.executeOperation("Cancel-Job", attributes, callback);
// };

// libPrinter.getJobAttributes = function (jobId, callback) {
//     const attributes = {
//       "operation-attributes-tag": {
//         "job-id": jobId,
//       },
//     };
//     this.executeOperation("Get-Job-Attributes", attributes, callback);
// };
  
// libPrinter.holdJob = function (jobId, callback) {
//     const attributes = {
//       "operation-attributes-tag": {
//         "job-id": jobId,
//         "job-hold-until": "indefinite",
//       },
//     };
//     this.executeOperation("Hold-Job", attributes, callback);
// };
  
// libPrinter.releaseJob = function (jobId, callback) {
//     const attributes = {
//       "operation-attributes-tag": {
//         "job-id": jobId,
//         "job-hold-until": "no-hold",
//       },
//     };
//     this.executeOperation("Release-Job", attributes, callback);
// };
  
// libPrinter.restartJob = function (jobId, callback) {
//     const attributes = {
//       "operation-attributes-tag": {
//         "job-id": jobId,
//       },
//     };
//     this.executeOperation("Restart-Job", attributes, callback);
// };
  
// // Administrative Actions
// libPrinter.getPrinterSupportedValues = function (callback) {
//     this.executeOperation("Get-Printer-Attributes", null, callback);
// };




// // Resume the Printer
// // libPrinter.resumePrinter((err, response) => {
// //   if (err) {
// //     console.error("Failed to resume printer:", err);
// //   } else {
// //     console.log("Printer resumed successfully:", response);
// //   }
// // });

// // Get Job Attributes
// libPrinter.getJobAttributes(3, (err, jobAttributes) => {
//   if (err) {
//     console.error("Failed to get job attributes:", err);
//   } else {
//     console.log("Job Attributes:", jobAttributes);
//   }
// });


// module.exports = libPrinter;

