lightLoginSchema = new SimpleSchema
  email:
    type: String
    regEx: SimpleSchema.RegEx.Email
  password:
    type: String
    min: 6
    max: 20

checkAndAuthenticate = (username, password) ->
  notifyWrongCase = (username, password) ->
    username.removeClass 'shake'
    password.removeClass 'shake'
    Meteor.setTimeout ->
      username.addClass 'shake'
      password.addClass 'shake'
    , 0
  unless Match.test \
      {email: username.val(), password: password.val()}, \
      lightLoginSchema
    notifyWrongCase username, password
    return false
  Meteor.loginWithPassword username.val(), password.val(), (err) ->
    return if err is undefined
    notifyWrongCase username, password
    return false

Template.login.rendered = ->
  Meteor.setTimeout ->
    @$ 'input[type=\'email\'], input[type=\'password\']'
    .each (idx, el) =>
      $el = @$ el
      $el.addClass 'filled' unless $el.val().length is 0
  , 300

Template.login.events
  'focus input[type=\'email\'], focus input[type=\'password\']': (e, t) ->
    (t.$ e.target).addClass 'filled'
  'blur input[type=\'email\'], blur input[type=\'password\']': (e, t) ->
    (t.$ e.target).removeClass 'filled' if e.target.value.length is 0
  'click button': (e, t) ->
    $button = t.$ e.target
    $button = $button.parent() unless $button.is 'button'
    $button.addClass 'clicked'
    $button.on ANIMATION_END_EVENT, ->
      $button
        .off ANIMATION_END_EVENT
        .removeClass 'clicked'
      checkAndAuthenticate (t.$ '[name=\'username\']'), \
        (t.$ '[name=\'password\']')
