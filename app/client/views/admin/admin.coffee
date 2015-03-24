Template.admin.helpers
  users: -> Meteor.users.find()

Template.admin.events
  'click [data-role=\'create-user\']': (e, t) ->
    e.preventDefault()
    Router.go '/admin/user/new'

Template.user.helpers
  title: ->
    civility = Template.instance().data.profile.civility
    if civility is 'Dr' then 'doc' else ''
  role: ->
    roles = _.flatten _.values Template.instance().data.roles
    if 'admin' in roles then 'admin' else ''

Template.insertUser.events
  submit: (e) ->
    console.log e
    e.preventDefault()

    #Router.go '/admin'

Template.insertUser.helpers
  civility: ->
    console.log UserSchema.schema()['profile.civility'].allowedValues
    UserSchema.schema()['profile.civility'].allowedValues
