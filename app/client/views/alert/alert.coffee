hideMessage = ->
  $ '[data-role=\'alert\']>main'
    .removeClass 'fadeInRight'
    .addClass 'fadeOutLeft'
    .on ANIMATION_END_EVENT, -> rxErrorMessage.set isDisplayed: false
lazyHideMessage = _.debounce hideMessage, 5000

rxErrorMessage = new ReactiveVar
@setError = (msg, title = 'Erreur') ->
  rxErrorMessage.set isDisplayed: true, title: title, msg: msg
  lazyHideMessage()

Template.alert.created = -> rxErrorMessage.set isDisplayed: false

Template.alert.helpers
  isDisplayed: -> rxErrorMessage.get().isDisplayed
  title: -> rxErrorMessage.get().title
  msg: -> rxErrorMessage.get().msg

Template.alert.events
  click: (e, t) -> hideMessage()
