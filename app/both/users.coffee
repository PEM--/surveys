@LoginSchema = new SimpleSchema
  email:
    type: String
    regEx: SimpleSchema.RegEx.Email
  password:
    type: String
    min: 6
    max: 20

nameRegEx = /^[a-z0-9A-Z_\-]{2,30}$/

@UserSchema = new SimpleSchema
  emails:
    type: [Object]
    min: 1
  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email
  createdAt:
    type: Date
    blackbox: true
  profile:
    type: Object
  'profile.civility':
    label: 'Civilité'
    type: String
    allowedValues: ['M.', 'Mlle', 'Mme', 'Dr']
  'profile.name':
    label: 'Nom'
    type: String
    min: 2
    max: 30
    regEx: nameRegEx
  'profile.forname':
    label: 'Prénom'
    type: String
    min: 2
    max: 30
    regEx: nameRegEx
  roles:
    blackbox: true
    type: Object
    optional: true
    allowedValues: ['admin']
  services:
    type: Object
    optional: true
    blackbox: true

Meteor.users.attachSchema @UserSchema

if Meteor.isServer
  if Meteor.users.find().count() is 0
    adminId = Accounts.createUser
      email: Meteor.settings.admin.email
      password: Meteor.settings.admin.password
      profile:
        name: Meteor.settings.admin.name
        forname: Meteor.settings.admin.forname
        civility: Meteor.settings.admin.civility
    Roles.addUsersToRoles adminId, ['admin'], Roles.GLOBAL_GROUP
  Meteor.publish null, -> Meteor.roles.find {}
  Meteor.users.permit ['insert', 'update', 'remove']
    .ifHasRole 'admin'
    .apply()
  Meteor.publish 'users', ->
    if Roles.userIsInRole @userId, 'admin'
      Meteor.users.find()
    else
      Meteor.users.find _id: @userId
  Meteor.methods
    mCreateUser: (login, profile, admin) ->
      unless Match.test login, LoginSchema
        throw new Meteor.Error 'mCreateUser', 'Login non validé'
      unless Match.test profile, UserSchema
        throw new Meteor.Error 'mCreateUser', 'Profile non validé'
      unless Match.test admin, Boolean
        throw new Meteor.Error 'mCreateUser', 'Option non validé'
      userId = Accounts.createUser
        email: login.email
        password: login.password
        profile:
          createdAt: new Date()
          name: profile.profile.name
          forname: profile.profile.forname
          civility: profile.profile.civility
      #Roles.addUsersToRoles userId, ['admin'], Roles.GLOBAL_GROUP if admin
