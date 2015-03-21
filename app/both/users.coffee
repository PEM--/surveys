@UserSchema = new SimpleSchema
  name:
    label: 'Nom'
    type: String
    min: 2
    max: 200
  forname:
    label: 'Prénom'
    type: String
    min: 2
    max: 200
  civility:
    label: 'Civilité'
    type: String
    allowedValues: ['M.', 'Mlle', 'Mme', 'Dr']
  username:
    label: 'Nom d\'utilisateur (email)'
    type: String
    regEx: SimpleSchema.RegEx.Email
  password:
    label: 'Mot de passe'
    type: String
    min: 6
    max: 10
  roles:
    type: Object
    blackbox: true

Meteor.users.attachSchema @UserSchema

if Meteor.isServer
  #Roles.addUsersToRoles userId, ['admin'], Roles.GLOBAL_GROUP
  Meteor.users.permit(['insert', 'update', 'remove']).ifHasRole('admin').apply()
