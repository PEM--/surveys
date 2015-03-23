rxErrorMessage = new ReactiveVar
@setError = (msg, title = 'Error') ->
  rxErrorMessage.set title: title, msg: msg

Template.alert.created = ->
  setError 'Error message'

Template.alert.helpers
  title: -> rxErrorMessage.get().title
  msg: -> title: -> rxErrorMessage.get().msg
