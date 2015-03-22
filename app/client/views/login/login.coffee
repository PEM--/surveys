Template.login.events
  'submit': (e, t) ->
    e.preventDefault()
    username = t.$ '[name=\'username\']'
    password = t.$ '[name=\'password\']'
    Meteor.loginWithPassword username.val(), password.val(), (err) ->
      return if err is undefined
      username.removeClass('shake')
      password.removeClass('shake')
      Meteor.setTimeout ->
        username.addClass('shake')
        password.addClass('shake')
      , 0
