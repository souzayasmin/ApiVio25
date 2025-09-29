require("dotenv").config();
const mysql = require("mysql2");

const pool = mysql.createPool({
  connectionLimit: 10,
  host: process.env.MYSQLPORT || process.env.DB_HOST,
  user: process.env.MYSQLPORT || process.env.DB_USER,
  password: process.env.MYSQLPORT || process.env.DB_PASSWORD,
  database: process.env.MYSQLPORT || process.env.DB_NAME,
  port: process.env.MYSQLPORT || 3306,
});

module.exports = pool;
