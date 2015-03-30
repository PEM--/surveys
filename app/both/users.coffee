nameRegEx = /^[a-z0-9A-Z_\-����]{2,30}$/

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
    label: 'Civilit�'
    type: String
    allowedValues: ['M.', 'Mlle', 'Mme', 'Dr']
  'profile.name':
    label: 'Nom'
    type: String
    min: 2
    max: 30
    regEx: nameRegEx
  'profile.forname':
    label: 'Pr�nom'
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
  # Meteor.users.permit ['insert', 'update', 'remove']
  #   .ifHasRole 'admin'
  #   .apply()
  Meteor.publish 'users', ->
    if Roles.userIsInRole @userId, 'admin'
      Meteor.users.find()
    else
      Meteor.users.find _id: @userId
  Meteor.methods
    mCreateUser: (user) ->
      return 'Yes'
      #throw new Meteor.error 'stuff', 'Marche pas ce machin'
      # check user,
      #   email: String
      #   password: String
      #   profile:
      #     name: String
      #     forname: String
      #     civility: String
      # unless Meteor.user().hasRole 'admin'
      #   console.log 'Current logged user isn\'t admin'
      #   return false
      # unless Match.test user, UserSchema
      #   console.log 'Shema validation failed'
      #   return false
