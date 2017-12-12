require("./static/css/app.scss");
require("./static/index.html");

const clean = require("./clean");

const calls = JSON.parse(require("./data/calls.js"));
const transcriptions = clean(JSON.parse(require("./data/transcriptions.js")));

const data = Object.assign(transcriptions, { calls });

console.log(data);

require("./elm/Main.elm").Main.embed(
  document.getElementById("main"),
  JSON.stringify(data)
);
