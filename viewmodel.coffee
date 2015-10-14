
Joi = require 'joi'
csrf = require 'csrf-lite'
fs = require 'fs'
jsonfile = require 'jsonfile'

# location for our schemes
schema = {}

# location for our models
models = {};

# load models from models dir
getModels = () ->
  console.log "getting models"
  models_path = "./models/"
  fs.readdirSync(models_path).forEach (filename, i) ->
    data = jsonfile.readFileSync(models_path + filename)
    # name the model it's filename (without extension)
    name = filename.split(".")[0]
    models[name] = data

getModels()



ViewModel = (modelname) ->
  @title = ""
  @pageTitle = ""
  @errors = []
  @setAsModel(modelname) if modelname
  return @

ViewModel::setAsModel = (modelname) ->
  return unless modelname
  @model = models[modelname]
  if not @model
    console.log "#{modelname} doesn't exist in models path:#{models_path}"
  return @

ViewModel::scheme = (name, scheme) ->
  return unless name
  schema[name] = scheme
  return @

ViewModel::validate = (name, payload) ->
  console.log("ViewModel::validate not built.")
  return @

ViewModel::updateModels = () ->
  getModels();
  return @

ViewModel::send = () ->
  @token = csrf()
  return @


module.exports = ViewModel



