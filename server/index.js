const express = require("express");
const app = express();
const { SERVER_PORT, CONNECTION_STRING } = process.env


app.listen(6969, () => {
  console.log("Listening boi");
});
