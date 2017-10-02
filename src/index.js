require("./static/css/app.scss");
require("./static/index.html");

require("./elm/Main.elm").Main.embed(document.getElementById("main"));
