var gulp       = require('gulp');
var autowatch  = require('gulp-autowatch');
var source     = require('vinyl-source-stream');
var buffer     = require('vinyl-buffer');
var cp         = require('child_process');

var dest = 'public';
var src  = {
  elm: 'main.elm'
} 

gulp.task('watch', function() {
  autowatch(gulp, {elm: './*.elm'});
});

gulp.task('elm', function() {
  var cmd  = 'elm-make ';
      cmd += src.elm;
      cmd += ' --output ';
      cmd += dest + '/elm.js';

  cp.exec(cmd, function(error, stdout){
    if (error){
      console.log('ELM ERROR', error);
    }
    console.log('ELM:', stdout);
  });
});

gulp.task('server', function() {
  require('./server.js');
});

gulp.task('default', ['elm', 'watch', 'server']);