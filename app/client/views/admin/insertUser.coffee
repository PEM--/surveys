Template.insertUser.created = ->
  @rxCivility = new ReactiveVar
  @rxCivility.set ''
  @autorun (computation) =>
    civility = @rxCivility.get()
    unless computation.firstRun
      $selectCustom = @$ '.select-custom'
      $selectCustom.addClass 'filled'

Template.insertUser.helpers
  civility: ->
    UserSchema.schema()['profile.civility'].allowedValues
  selectedCivility: -> Template.instance().rxCivility.get()

Template.insertUser.events
  'focus input[type=\'email\'], \
    focus input[type=\'password\'], \
    focus input[type=\'text\']': (e, t) ->
    (t.$ e.target).addClass 'filled'
  'blur input[type=\'email\'], \
    blur input[type=\'password\'], \
    blur input[type=\'text\']': (e, t) ->
    (t.$ e.target).removeClass 'filled' if e.target.value.length is 0
  'click .select-custom li': (e, t) ->
    t.rxCivility.set e.target.textContent

  'click button': (e, t) ->
    $button = t.$ e.target
    $button = $button.parent() unless $button.is 'button'
    $button.addClass 'clicked'
    $button.on TRANSITION_END_EVENT, ->
      $button
        .off TRANSITION_END_EVENT
        .removeClass 'clicked'
