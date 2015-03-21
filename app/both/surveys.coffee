@Surveys = new Meteor.Collection 'surveys'
@Surveys.attachSchema @SurveysSchema
@SurveysSchema = new SimpleSchema
  name:
    type: String
    label: 'Nom'
    max: 200
  buys:
    type: [Number]
    label: 'Achats'
    optional: true
    max: 1000
