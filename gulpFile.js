var gulp = require("gulp");
var source = require("vinyl-source-stream");
var buffer = require("vinyl-buffer");
var cp = require("child_process");
var browserify = require("browserify");
var util = require("gulp-util");


var paths = {
  public: "./public",
  dist: "./dist",
  mainElm: "./src/Main.elm",
  elm: "./src/**/*.elm",
  js: "./src/*.js"
};

gulp.task("js", function() {
  return browserify("./src/app.js")
    .bundle()
    .pipe(source("app.js"))
    .pipe(buffer())
    .pipe(gulp.dest(paths.public));
});


gulp.task("elm", ["elm-make"]);

gulp.task("elm-make", function() {
  var cmd = [
    "elm-make",
    paths.mainElm,
    "--warn",
    "--output",
    paths.public + "/elm.js"
  ].join(" ");
  return cp.exec(cmd, function(error, stdout, stderr) {
    if (error) {
      error = (String(error)).slice(0, (String(error)).length - 1);
      (error.split("\n")).forEach(function(line) {
        return util.log(util.colors.red(String(line)));
      });
    } else {
      stderr = stderr.slice(0, stderr.length - 1);
      (stderr.split("\n")).forEach(function(line) {
        return util.log(util.colors.yellow(String(line)));
      });
    }
    stdout = stdout.slice(0, stdout.length - 1);
    return (stdout.split("\n")).forEach(function(line) {
      return util.log(util.colors.cyan("Elm"), line);
    });
  });
});

gulp.task("server", function() {
  return require("./server")(2960, util.log);
});

gulp.task("dist", function() {
  production = true;
  gulp.task("default");

  return gulp
    .src(paths.public + "/**/*")
    .pipe(gulp.dest(paths.dist));
})

gulp.watch(paths.elm, ["elm"]);
gulp.watch(paths.js, ["js"]);

gulp.task("default", ["elm", "js", "server"]);
