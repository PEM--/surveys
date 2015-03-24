Template.admin.helpers
  users: -> Meteor.users.find()

Template.user.helpers
  title: ->
    civility = Template.instance().data.profile.civility
    if civility is 'Dr' then 'doc' else ''
  role: ->
    roles = _.flatten _.values Template.instance().data.roles
    if 'admin' in roles then 'admin' else ''
