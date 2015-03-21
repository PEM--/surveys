Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> Meteor.subscribe 'surveys'

# Route declaration
Router.map ->
  @route 'home', path: '/'
  @route 'surveys', data: -> Surveys.find()
  @route '/surveys/:_id',
    action: ->
      return @render 'upsert-survey' if @params._id is 'new'
      @data = Surveys.findOne @params._id
      return @render 'notFound' if @data is undefined
      @render 'upsert-survey'
