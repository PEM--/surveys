Template.admin.helpers
  users: -> Meteor.users.find()

Template.admin.events
  'click button[data-role=\'create-user\']': (e, t) ->
    $button = t.$ e.target
    $button = $button.parent() unless $button.is 'button'
    $button.addClass 'clicked'
    $button.on TRANSITION_END_EVENT, ->
      $button
        .off TRANSITION_END_EVENT
        .removeClass 'clicked'
      Router.go '/admin/user/new'

Template.user.helpers
  title: ->
    civility = Template.instance().data.profile.civility
    if civility is 'Dr' then 'doc' else ''
  role: ->
    return '' unless Template.instance().data.roles?
    roles = _.flatten _.values Template.instance().data.roles
    if 'admin' in roles then 'admin' else ''
