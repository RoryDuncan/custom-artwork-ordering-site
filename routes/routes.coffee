
module.exports = (server) ->

  # index
  server.route
    method: 'GET'
    path: '/'
    handler:
      view:
        template: 'index'
        context: {}

  # customize
  server.route
    method: 'GET'
    path: '/customize'
    handler:
      view:
        template: 'customize'
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
