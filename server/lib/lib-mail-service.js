const nodemailer = require('nodemailer');
const path = require('path');
const fs = require('fs');

/**
 * Address object for handling email addresses.
 */
function msgAddrObject(emailAddr) {
    this.name = null;
    this.email = null;

    this.toString = function () {
        return this.name ? `${this.name} <${this.email}>` : this.email;
    };

    if (typeof emailAddr === 'string') {
        let pos = emailAddr.indexOf('<');
        this.name = pos > 0 ? emailAddr.substring(0, pos).trim() : null;
        this.email = pos > 0 ? emailAddr.substring(pos + 1, emailAddr.indexOf('>')).trim() : emailAddr;
    };
}

/**
 * Message object for holding email data.
 */
function msgObject() {
    this.from = null;
    this.to = null;
    this.cc = null;
    this.bcc = null;
    this.subject = null;
    this.bodyHtml = null;
    this.attachments = [];

    this.attachFile = function (filePath) {
        this.attachments.push({
            filename: path.basename(filePath),
            path: filePath
        });
    };
}

/**
 * Mail client for sending emails.
 */
function MailClient({ host, port, secure, auth }) {
    const transporter = nodemailer.createTransport({
        host,
        port,
        secure,
        auth
    });

    /**
     * Send an email.
     * @param {msgObject} msg
     */
    this.sendMail = async function (msg) {
        try {
            const mailOptions = {
                from: msg.from.toString(),
                to: Array.isArray(msg.to) ? msg.to.map(r => r.toString()).join(',') : msg.to,
                cc: msg.cc ? (Array.isArray(msg.cc) ? msg.cc.map(r => r.toString()).join(',') : msg.cc) : undefined,
                bcc: msg.bcc ? (Array.isArray(msg.bcc) ? msg.bcc.map(r => r.toString()).join(',') : msg.bcc) : undefined,
                subject: msg.subject,
                html: msg.bodyHtml,
                attachments: msg.attachments
            };
            await transporter.sendMail(mailOptions);
        } catch (err) {
            console.error('Failed to send email:', err);
        }
    };
}

module.exports = {
    MailClient,
    msgAddrObject,
    msgObject
};
