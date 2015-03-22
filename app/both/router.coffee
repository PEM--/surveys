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
  @route '/survey/:_id', name: 'survey', data: -> Surveys.findOne @params._id
  @route '/surveys/:_id',
    action: ->
      return @render 'upsert-survey' if @params._id is 'new'
      @data = Surveys.findOne @params._id
      return @render 'notFound' if @data is undefined
      @render 'upsert-survey'
