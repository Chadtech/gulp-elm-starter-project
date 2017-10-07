# HI THERE

This is my 

# Elm Gulp Browserify Boilerplate

Its basically a template development environment with all of my favorite dependencies. It also might be useful to look at, if you are learning how to use Elm.

How to get going..
```
> git clone https://github.com/Chadtech/elm-gulp-browserify-boilerplate new-project
> cd new-project
> npm install
> elm package install --yes
> gulp

then open up http://localhost:2984
```


This repo is organized as ..
```
dist/                     -- Your production-ready app
dev/                      -- Your development app
  index.html
  assets/                 -- Where you can put images, fonts, etc.
source/                   -- Source files
  app.js                  -- Loads your elm file, and handles ports
  Main.elm
  *.elm
  main.styl               -- First style file, concat([main.style, .. ])
  View/
    Main.elm              -- Your main view file
    point.styl
    input-field.styl
gulpFile.js
server.js


## Dist

To compile to `dist` type into your terminal..

```
gulp dist
```

It will run the js command without debug on. Its pretty sparse in what it does, but if you have your own dist operations, you can put them in that gulp task.


## Elm Format

There is an [Elm-Format](https://github.com/avh4/elm-format) task in this gulp file. Its not on by default, but you can switch to it by uncommenting a little code. 