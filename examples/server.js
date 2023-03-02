const express = require("express");

const path = require("path");
const port = process.env.PORT || 3001;
const app = express();

app.use(express.static(__dirname));
app.use(express.static(path.join(__dirname, "dist")));
app.get("/*", function (req, res) {
  console.log("this works");
  res.sendFile(path.join(__dirname, "dist", "index.html"));
});
app.listen(port);
