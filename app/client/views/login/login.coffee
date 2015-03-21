Template.login.events
  'submit': (e, t) ->
    e.preventDefault()
    username = (t.$ '[name=\'username\']').val()
    password = (t.$ '[name=\'password\']').val()
    Meteor.loginWithPassword username, password, (e) ->
      Router.go 'home'
