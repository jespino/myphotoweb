gulp = require('gulp')
coffee = require('gulp-coffee')
less = require('gulp-less')
jade = require('gulp-jade')
clean = require('gulp-clean')
config = require('./config.coffee')

gulp.task "less", ->
    gulp.src("templates/#{config.template}/less/*.less")
        .pipe(less())
        .pipe(gulp.dest('dist/css'))

gulp.task "coffee", ->
    gulp.src("templates/#{config.template}/coffee/*.coffee")
        .pipe(coffee())
        .pipe(gulp.dest('dist/js'))

gulp.task "jade", ->
    gulp.src("pages/*.jade")
        .pipe(jade())
        .pipe(gulp.dest('dist/'))

gulp.task 'clean', ->
    gulp.src(['dist/'], {read: false})
        .pipe(clean())

gulp.task 'default', ['clean'], ->
    gulp.start 'less', 'coffee', 'jade'
