Template.home.created = ->
  console.log @data

Template.home.events
  'click [data-role=\'new\']': (e) -> Router.go '/surveys/new'
  'click [data-role=\'view\']': (e) ->
    Router.go "/survey/#{e.target.getAttribute 'data-value'}"
  'click [data-role=\'modify\']': (e) ->
    Router.go "/surveys/#{e.target.getAttribute 'data-value'}"
