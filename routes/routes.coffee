
ViewModel = require '../viewmodel.js'

module.exports = (server) ->

  server.state "_token", {
    ttl: 60*60*1000
    isSecure: false
    isHttpOnly: true
    encoding: 'base64json'
  }

  # index
  server.route
    method: 'GET'
    path: '/'
    handler:
      view:
        template: 'index'
        context: {}

  # shop
  server.route
    method: 'GET'
    path: '/shop'
    handler:
      view:
        template: 'shop'
        context: {}

  # customize
  server.route
    method: 'GET'
    path: '/customize'
    handler: (req, reply) ->
      viewmodel = new ViewModel("customize")
      console.log viewmodel
      reply.view("customize", viewmodel.send()).state("_token", viewmodel.token)

  # faq
  server.route
    method: 'GET'
    path: '/faq'
    handler:
      view:
        template: 'faq'
        context: {}

  # contact
  server.route
    method: 'GET'
    path: '/contact'
    handler:
      view:
        template: 'contact'
        context: {}

  ## favicon
  server.route
      method: 'GET'
      path:'/favicon.ico'
      handler: (request, reply) ->
        reply.file("./favicon.ico");

  ## images
  server.route
    method: 'GET'
    path: '/images/{file*}'
    handler:
      directory:
        path: 'public/images',
        listing: true

  ## css
  server.route
    method: 'GET'
    path: '/css/{file*}'
    handler:
      directory:
        path: 'public/css'
        listing: true

  ## scripts
  server.route
    method: 'GET'
    path: '/scripts/{file*}'
    handler:
      directory:
        path: 'public/scripts'
        listing: true

  ## generic file
  server.route
    method: 'GET'
    path: '/{file*}'
    handler:
      directory:
        path: 'public'
        listing: true
