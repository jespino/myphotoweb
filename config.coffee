_ = require('lodash')
fs = require('fs')

module.exports = {
    title: "Title"
    template: "default"
    thumbnailSize: [100, 75]
    getCategories: ->
        return _.uniq (photo.category for photo in @.photos)
}

if fs.existsSync('./config.local.coffee')
    configlocal = require('./config.local.coffee')
    module.exports = _.extend(module.exports, configlocal)
else
    console.log "Create config.local.config to configure your photo web gallery"
