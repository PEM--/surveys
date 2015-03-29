@UserSchema = new SimpleSchema
  emails:
    type: [Object]
    min: 1
  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email
  createdAt:
    type: Date
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
    regEx: /^[a-z0-9A-Z_]{2,30}$/
  'profile.forname':
    label: 'Prénom'
    type: String
    min: 2
    max: 30
    regEx: /^[a-z0-9A-Z_]{2,30}$/
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
  ###
  Meteor.methods
    createUser: (user) ->
      unless Meteor.user().hasRole 'admin'
        console.log 'Current logged user isn\'t admin'
        return false
      unless Match.test user, UserSchema
        console.log 'Shema validation failed'
        return false
  ###
