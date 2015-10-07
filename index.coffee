
Hapi = require 'hapi'
Vision = require 'vision'
Inert = require 'inert'
fs = require 'fs'



server = new Hapi.Server()
server.connection({port: process.env.PORT or 5000})

server.register Vision, (err) ->
  throw err if err

  # add our view engine
  server.views
    engines:
      jade: require('jade')
    relativeTo: __dirname
    path: 'views'
    isCached: false

  # register inert for static assets
  server.register Inert, (err) ->
    throw err if err

    # add our routes
    require("./routes/routes.js")(server)

    # start server
    server.start () ->
      console.log "\nServer running on #{server.info.uri}\n"
