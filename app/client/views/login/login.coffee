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

Template.login.events
  'focus input[type=\'email\'], focus input[type=\'password\']': (e, t) ->
    (t.$ e.target).addClass 'filled'
  'blur input[type=\'email\'], blur input[type=\'password\']': (e, t) ->
    (t.$ e.target).removeClass 'filled' if e.target.value.length is 0
  'submit': (e, t) ->
    e.preventDefault()
    checkAndAuthenticate (t.$ '[name=\'username\']'),(t.$ '[name=\'password\']')
