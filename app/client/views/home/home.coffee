checkedInsertRemove = (e, isInsertion) ->
  e.preventDefault()
  id = e.target.getAttribute 'data-value'
  if Match.test id, String
    if isInsertion
      survey = _.omit (_.findWhere Template.instance().data, _id: id), '_id'
      Surveys.insert survey, (err) ->
        setError 'Problème lors de l\'insertion' if err
    else
      Surveys.remove (e.target.getAttribute 'data-value'), (err) ->
        setError 'Erreur à l\'effacement' if err
  else
    setError 'Identifiant inconnu'

Template.home.events
  'click [data-role=\'new\']': (e) ->
    e.preventDefault()
    Router.go '/surveys/new'
  'click [data-role=\'view\']': (e) ->
    e.preventDefault()
    Router.go "/survey/#{e.target.getAttribute 'data-value'}"
  'click [data-role=\'modify\']': (e) ->
    e.preventDefault()
    Router.go "/surveys/#{e.target.getAttribute 'data-value'}"
  'click [data-role=\'copy\']': (e) -> checkedInsertRemove e, true
  'click [data-role=\'remove\']': (e) -> checkedInsertRemove e, false

AutoForm.hooks
  insertSurvey: onSuccess: -> Router.go '/'
  updateSurvey: onSuccess: -> Router.go '/'
