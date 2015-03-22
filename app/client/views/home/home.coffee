Template.home.created = ->
  console.log @data

Template.home.events
  'click [data-role=\'new\']': (e, t) ->
    e.preventDefault()
    Router.go '/surveys/new'
