const { src, dest, parallel, series, watch } = require('gulp');
const elm = require('gulp-elm');
const fs = require('fs');
const http require('http');

const model = {
    optimizeElm : false,
};

function devDestDir(path) {
    const root = "./public";
    if (typeof path === "undefined") {
        return root;
    }
    return root + "/" + path;
}

function compile_elm() {
    return src('src/Main.elm')
        .pipe(elm.bundle("elm.js", {
            optimize: model.optimizeElm,
            elm: "./node_modules/elm/bin/elm"
        }))
        .pipe(dest(devDestDir()));
}

function compileElmBasic(params) {
    return src('src/Main.elm')
        .pipe(elm.bundle("elm.js", {
            optimize: params.optimize,
            elm: "./node_modules/elm/bin/elm"
        }))
        .pipe(dest(devDestDir()));
}

function compile_js() {
    return src("src/app.js").pipe(dest(devDestDir()));
}

function dev_server() {
    const requestListener = function (req, res) {
        res.writeHead(200);
        res.end('Hello, World!');
    }

    const server = http.createServer(requestListener);
    server.listen(8080);
}

exports.dev = function() {
    parallel(compile_elm, compile_js)();
    watch("src/**/*.elm", compile_elm);
    watch("src/app.js", compile_js);
}

exports.buildProd = function(cb) {
    model.optimizeElm = true;
    series(compile_elm, compile_js)();
    cb();
}