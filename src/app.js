var app = Elm.Main.init();

function toElm(type, body) {
	app.ports.fromJs.send({
		type: type,
		body: body
	});
}

function square(n) {
	toElm("square computed", n * n);
}

var actions = {
	consoleLog: console.log,
	square: square
}

function jsMsgHandler(msg) {
	var action = actions[msg.type];
	if (typeof action === "undefined") {
		console.log("Unrecognized js msg type ->", msg.type);
		return;
	}
	action(msg.body);
}

app.ports.toJs.subscribe(jsMsgHandler)

