AutoForm.setDefaultTemplateForType 'afObjectField', 'personal'

Template.afObjectField_personal.helpers
  quickFieldsAtts: ->
    _.pick @, 'name', 'id-prefix'
