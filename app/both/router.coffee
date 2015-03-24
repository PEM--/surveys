Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> Meteor.subscribe 'surveys'
  onBeforeAction: ->
    unless Meteor.userId()
      @render 'login'
    else
      @next()

# Route declaration
Router.map ->
  @route '/home', path: '/', data: -> Surveys.find().fetch()
  @route '/survey/new', name: 'insertSurvey'
  @route '/survey/:_id', name: 'survey', data: -> Surveys.findOne @params._id
  @route '/survey/edit/:_id', name: 'updateSurvey', \
    data: -> Surveys.findOne @params._id
  @route '/admin'
  @route '/admin/user/new', name: 'insertUser'
