
document.ready = []

# set any '.fullpage' class to be the viewport height - navbar height
items = document.querySelectorAll '.fullpage'
height = window.innerHeight - 85
for item in items
  item.style['min-height'] = "#{height}px"


document.onreadystatechange = (e) ->
   if document.readyState is "interactive"
      document.ready.forEach (el) ->
        el.call()

document.ready.push () ->
  # cache selectors
  mobilenav = document.querySelectorAll('.navigation .mobile ul.nav')[0]
  navToggle = document.querySelectorAll('.navigation .mobile .toggle-nav')[0]

  navToggle.addEventListener "click", (e) ->
    mobilenav.classList.toggle("active")
    navToggle.classList.toggle("active")
    e.preventDefault()

    landscape.addEventListener "change", invertDimensions



