


# our cache'd dom parts
canvas = document.getElementById('size')
customtext = document.getElementById('customtext')
material = document.getElementById('material')
materials = {
  'panel': document.getElementById("material-panel"),
  'wood': document.getElementById('material-wood'),
  'canvas': document.getElementById('material-canvas')
}
dimensionSelect = {
  'canvas': document.getElementById("canvas-dimensions"),
  'panel': document.getElementById("panel-dimensions"),
  'wood': document.getElementById("wood-dimensions")
}

sizes = document.querySelectorAll(".sizes .size")
dimensions = document.querySelectorAll(".dimensions")
landscape = document.getElementById("landscape")

colors = {
  'pickcolors': document.querySelector(".pick-colors")
  'artistchoice': document.getElementById("artist-choice")
  'add': document.getElementById("add-another-color")
  'colors': document.querySelector(".colors")
  'color': document.querySelectorAll(".colors .color")
  'max': 5
  'min': 2
  'count': 2
}

document.ready.push () ->

  for key, m of materials
    do (material) ->
      if material.value is key
        m.classList.add("active")
      m.addEventListener("click", changeMaterial)
  showDimensionsOfSelected()

  dimensionSelect.canvas.addEventListener "change", showPreviewProportions
  dimensionSelect.panel.addEventListener "change", showPreviewProportions
  dimensionSelect.wood.addEventListener "change", showPreviewProportions
  landscape.addEventListener "change", invertDimensions
  customtext.addEventListener "keydown", updateLetterCount
  colors.artistchoice.addEventListener "click", toggleColorPicking
  colors.add.addEventListener "click", addColorPicker
  showPreviewProportions()



# functions



## color picker


# updates the non-live collection of '.colors .color', and updates our count of it
colorPickerUpdate = () ->
  colors.color = document.querySelectorAll(".colors .color")
  colors.count = colors.color.length
  return

# adds colors when you click the "Add another color button"
addColorPicker = (e) ->
  colorPickerUpdate()
  count = colors.count
  return unless (colors.count < colors.max)
  if colors.count is (colors.max - 1)
    colors.add.classList.toggle("hidden")

  #console.log colors.color
  clone = colors.color[1].cloneNode(true)
  selector = "color#{count}"

  clone.querySelector("label").setAttribute "for", selector
  clone.querySelector("label").textContent = "pick color #{count}"
  clone.querySelector("input").setAttribute "name", selector
  clone.querySelector("input").setAttribute "id", selector
  colors.colors.appendChild(clone)
  # event listerner to remove it
  clone.querySelector("a.close").addEventListener "click", removeColorPicker
  return

# removes the colorpicker associated with the event.target's a.close
removeColorPicker = (e) ->
  colorPickerUpdate()
  for color in colors.color
    if color.contains(e.target)
      do (color) ->
        color.classList.toggle("fadeout")
        # act after the fadeout has finished (200ms)
        window.setTimeout () ->
          color.remove()
          colorPickerUpdate()
          if colors.count <= colors.max - 1
            colors.add.classList.remove("hidden")
        , 250

# toggles custom color picking option
toggleColorPicking = (e) ->
  colors.pickcolors.classList.toggle("active")


## text content count


# updates the number of letters taken up
updateLetterCount = (e) ->
  current = document.getElementById("char-count")
  current.textContent = e.target.value.length
  if parseInt(current.textContent, 10) > parseInt(document.getElementById("char-max").textContent, 10)
    current.classList.add("overflow")
  else
    current.classList.remove("overflow")


## preview canvas feature


# changes the material and handles displaying the corresponding section
changeMaterial = (e) ->
  for m of materials
    materials[m].classList.remove("active")

  mat = @getAttribute("data-select")
  material.value = mat;
  materials[mat].classList.add("active")
  showDimensionsOfSelected()


showDimensionsOfSelected = () ->
  value = material.value

  for el, i in sizes
    if el.getAttribute("data-select") is value
      el.classList.add("active")
    else
      el.classList.remove("active")


# inverts the height and width dimensions of all the dimension dropdown
invertDimensions = (e) ->
  for name, select of dimensionSelect
    options = select.children
    for i in [0...select.children.length]
      n = options[i].value.split("x")
      options[i].value = "#{n[1]}x#{n[0]}"
      options[i].textContent = "#{n[1]} × #{n[0]}"

  showPreviewProportions()
  return

# update the canvas to display the proportions and layout
showPreviewProportions = () ->
  target = document.querySelectorAll(".sizes.active select")[0]
  target = dimensionSelect[material.value]
  value = target.value.split("x")
  x = 0
  y = 1
  width = parseInt(value[x], 10)
  height = parseInt(value[y], 10)
  scale = 14
  canvas.width = width * scale
  canvas.height = height * scale

  ctx = canvas.getContext('2d')
  ctx.fillStyle = "#eee"
  ctx.strokeStyle = "#b2b2b2"
  ctx.rect(0,0, canvas.width, canvas.height)
  ctx.fill()
  ctx.stroke()
  ctx.fillStyle = "#888"
  ctx.font = "#{scale}px Open Sans"
  ctx.textAlign = "center"
  ctx.fillText("#{value[x]} × #{value[y]}", (canvas.width* 0.5), ((canvas.height+scale)*0.5))
