const escpos = require('escpos');
escpos.Network = require('escpos-network');

function libPrinter() {};

// Internal variables to hold the printer instance and configuration
let device = null;
let printer = null;

/**
   * Initializes the printer with a given network URL (IP address and port).
   * @param {string} printerUrl - The printer's IP address.
   * @param {number} port - The printer's port (default is 9100).
   */
libPrinter.init = function (printerUrl, port = 5000) {
    if (!printerUrl) {
      throw new Error("Printer URL must be provided during initialization.");
    }
    device = new escpos.Network(printerUrl, port);
    printer = new escpos.Printer(device);
    console.log(`Printer initialized at: ${printerUrl}:${port}`);
};

/**
* Prints text to the printer.
* @param {string} text - The text to print.
*/
libPrinter.printText = async function (text) {
    if (!device || !printer) {
      throw new Error("Printer is not initialized. Call init() first.");
    }
    try {
      await new Promise((resolve, reject) => {
        device.open((err) => {
          if (err) reject(err);
          else resolve();
        });
      });
      printer.text(text).cut().close();
    } catch (error) {
      console.error("Error printing text:", error);
    }
};

/**
* Prints an image to the printer.
* @param {string} imagePath - The path to the image file.
*/
libPrinter.printImage = async function (imagePath) {
    if (!device || !printer) {
      throw new Error("Printer is not initialized. Call init() first.");
    }
    try {
      await new Promise((resolve, reject) => {
        device.open((err) => {
          if (err) reject(err);
          else resolve();
        });
      });
      printer.image(imagePath).then(() => {
        printer.cut().close();
      }).catch((error) => {
        console.error("Error printing image:", error);
      });
    } catch (error) {
      console.error("Error connecting to printer:", error);
    }
};

/**
* Prints a QR code.
* @param {string} data - The data to encode in the QR code.
*/
libPrinter.printQRCode = async function (data) {
    if (!device || !printer) {
      throw new Error("Printer is not initialized. Call init() first.");
    }
    try {
      await new Promise((resolve, reject) => {
        device.open((err) => {
          if (err) reject(err);
          else resolve();
        });
      });
      printer.qrimage(data, { type: 'png', mode: 'dhdw' }, () => {
        printer.cut().close();
      });
    } catch (error) {
      console.error("Error printing QR code:", error);
    }
};

// const libPrinter = require('./libPrinter');

// Initialize the printer
libPrinter.init('192.168.14.2'); // Replace with your printer's IP
(async () => {
  try {
    await libPrinter.printText("Hello, World!\nWelcome to ESC/POS printing.");
  } catch (error) {
    console.error("Error during text printing:", error);
  }
})();



module.exports = libPrinter;
