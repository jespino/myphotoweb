gulp = require('gulp')
coffee = require('gulp-coffee')
less = require('gulp-less')
jade = require('gulp-jade')
rimraf = require('gulp-rimraf')
config = require('./config.coffee')
concat = require('gulp-concat')
imageResize = require('gulp-image-resize')
rename = require('gulp-rename')
path = require('path')
merge = require('merge-stream')

_ = require('lodash')

gulp.task "less", ->
    gulp.src("templates/#{config.template}/less/*.less")
        .pipe(less())
        .pipe(gulp.dest('dist/css'))

gulp.task "images", ->
    gulp.src((photo.path for photo in config.photos))
        .pipe(gulp.dest('dist/imgs'))
        .pipe(imageResize({
            width : config.thumbnailSize[0],
            height : config.thumbnailSize[1],
            crop : true,
            upscale : true
        }))
        .pipe(rename({suffix: "-thumbnail"}))
        .pipe(gulp.dest('dist/imgs'))

gulp.task "coffee", ->
    gulp.src("templates/#{config.template}/coffee/*.coffee")
        .pipe(coffee())
        .pipe(gulp.dest('dist/js'))

gulp.task "jade", ->
    tasks = []
    _.each config.getCategories(), (category) ->
        task = gulp.src("pages/category.jade")
                   .pipe(jade({locals: _.extend({}, config, {
                       category: category
                       thumbnail: (filePath) -> "#{path.basename(filePath, ".png")}-thumbnail#{path.extname(filePath)}"
                   })}))
                   .pipe(concat("category-#{category}.html"))
                   .pipe(gulp.dest("dist/"))
        tasks.push task

    task = gulp.src("pages/index.jade")
               .pipe(jade({locals: config}))
               .pipe(gulp.dest('dist/'))
    tasks.push task

    return merge.apply(merge, tasks)

gulp.task 'clean', ->
    gulp.src(['dist/'], {read: false})
        .pipe(rimraf())

gulp.task 'default', ['clean'], ->
    gulp.start 'less', 'coffee', 'jade', 'images'
