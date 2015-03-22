@SurveysSchema = new SimpleSchema
  name:
    type: String
    label: 'Nom'
    max: 200
    autoform: placeholder: 'Nom du questionnaire'
  question:
    type: String
    label: 'Question'
    max: 200
    autoform: placeholder: 'Question du questionnaire'
  answers:
    type: [String]
    label: 'Réponses'
    minCount: 4
    maxCount: 4
  'answers.$.answer':
    type: String
    label: 'Réponse'
    max: 200
    autoform: placeholder: 'Sélection possible du répondant'
  populations:
    type: [Object]
    minCount: 1
    maxCount: 4
  'populations.$.population.name':
    type: String
    label: 'Nom de la population'
    max: 200
    autoform: placeholder: 'Nom de la population'
  'populations.$.population.values':
    type: [Number]
    label: 'Valeurs'
    decimal: true
    minCount: 4
    maxCount: 4
  'populations.$.population.values.$.value':
    type: Number
    label: 'Valeur'
    decimal: true
    min: 0.0
    max: 100.0
@Surveys = new Meteor.Collection 'surveys'
@Surveys.attachSchema @SurveysSchema

if Meteor.isServer
  Meteor.publish 'surveys', -> Surveys.find()
  @Surveys.permit(['insert', 'update', 'remove']).ifLoggedIn().apply()
