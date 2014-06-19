_ = require('lodash')
path = require('path')

module.exports = {
    title: "Title"
    template: "default"
}

if path.existsSync('./config.local.coffee')
    configlocal = require('./config.local.coffee')
    module.exports = _.extend(module.exports, configlocal)
else
    console.log "Create config.local.config to configure your photo web gallery"
