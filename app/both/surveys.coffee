@Surveys = new Meteor.Collection 'surveys'
@Surveys.attachSchema @SurveysSchema
@SurveysSchema = new SimpleSchema
  name:
    type: String
    label: 'Nom'
    max: 200
  question:
    type: String
    label: 'Question'
    max: 200
  answers:
    type: [String]
    label: 'Réponses'
    min: 4
    max: 4
  'answers.$.answer':
    type: Object
    label: 'Réponse'
    max: 200
  populations:
    type: [Object]
    label: 'Populations'
    min: 1
    max: 4
  'populations.$.population.name':
    type: String
    label: 'Nom de la population'
    max: 200
  'populations.$.population.values':
    type: [Number]
    label: 'Valeurs'
    min: 4
    max: 4
  'populations.$.population.values.$.value':
    type: Number
    label: 'Valeur'
    min: 0
    max: 100

if Meteor.isServer
  Meteor.publish 'surveys', -> Surveys.find()
  @Surveys.permit(['insert', 'update', 'remove']).ifLoggedIn().apply()
