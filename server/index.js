const express = require("express");
const app = express();
const { SERVER_PORT, CONNECTION_STRING } = process.env


app.listen(SERVER_PORT, () => {
  console.log("Listening boi");
});
