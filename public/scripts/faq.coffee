console.log "bingo bango"


search = document.getElementById("search")
faqlist = document.querySelector("ul.faq")
data = []
qa = faqlist.querySelectorAll("li")
console.log "datums:", qa.length
for i in [0...qa.length]
  do (i) ->
    question = qa[i].children[0]
    answer = qa[i].children[1]
    data.push question.textContent
    data.push answer.textContent

# an empty function
noop = () ->
  return

# debounce
# returns a function that calls if
# it hasn't been called in <debounceTime> milliseconds
# it is called initially, and after the last trigger (leading; tailing)
debounce = (fn = noop, debounceTime = 0, context = null) ->
  lastCalled = Date.now()
  tailing = null
  return (args...) ->
    now = Date.now()
    if now - lastCalled < debounceTime
      window.clearTimeout tailing unless tailing is null
      tailing = setTimeout () ->
        fn.apply(context, args)
      , debounceTime + 1
    else
      fn.apply(context, args)
    lastCalled = now

stopSearching = () ->
  faqlist.classList.remove("searching")
  clearSearch();

clearSearch = () ->
  for el, i in qa
    el.classList.remove("result")

filter = (e) ->
  clearSearch();
  if this.value.length < 2
    stopSearching();
    return;
  faqlist.classList.add("searching")
  console.log this.value
  results = fuzzy.filter this.value, data
  return if results.length is 0

  for i, v of results
    do (i, v) ->
      console.log i
      index = if v.index % 2 is 0 then (v.index / 2) else (v.index - 1) / 2
      console.log index, "of", qa.length, "->",  qa[index]
      qa[index].classList.add("result")


debouncedFilter = debounce(filter, 200, search)


document.ready.push () ->
  search.addEventListener "keyup", debouncedFilter

