const fs = require('fs');
const path = require('path');
const currentWorkingDirectory = process.cwd();

// Create a log directory if it doesn't exist
const logDir = path.join(__dirname, 'logs');

// Ensure the log directory exists
if (!fs.existsSync(logDir)) {
    fs.mkdirSync(logDir, { recursive: true });
}

// The actual log function (libLog)
function libLog(filename, action, message) {
    // Get current date and format it as YYYY-MM-DD
    const currentDate = new Date().toISOString().split('T')[0];

    // Create the log file path (e.g., logs/2025-01-02.txt)
    const logFilePath = path.join(logDir, `${currentDate}.txt`);

    // Create log entry with timestamp, filename, action, and message
    const logEntry = `[${new Date().toISOString()}] - ${filename} - ${action} - ${message}\n`;

    // Append the log entry to the file
    fs.appendFileSync(logFilePath, logEntry, 'utf8');
    console.log('Log added:', logEntry); // Optional: log to console for debugging
}

// Export the libLog function
module.exports = libLog;
