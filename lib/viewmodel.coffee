
_defaults = defaults = {
  title: ""
}


ViewModel = (options = defaults) ->


  @[key] = value for key, value in options
  return @

ViewModel::setDefaults = (override) ->
  defaults = override
  return


ViewModel::add = (key, obj) ->
  @[key] = obj
  return @
