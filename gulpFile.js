const { src, dest, parallel, series, watch } = require('gulp');
const elm = require('gulp-elm');
const fs = require('fs');
const server = require('./server');

const model = {
    optimizeElm : false,
    server: null
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

exports.dev = function() {
    parallel(compile_elm, compile_js)();
    watch("src/**/*.elm", compile_elm);
    watch("src/app.js", compile_js);
    server(6888, console.log);
}

exports.buildProd = function(cb) {
    model.optimizeElm = true;
    series(compile_elm, compile_js)();
    cb();
}