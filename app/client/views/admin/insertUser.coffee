Template.insertUser.created = ->
  @rxCivility = new ReactiveVar
  @rxCivility.set ''
  @autorun (computation) =>
    civility = @rxCivility.get()
    unless computation.firstRun
      $selectCustom = @$ '.select-custom'
      $selectCustom.addClass 'filled'
  @userCtx = UserSchema.newContext()
  @loginCtx = LoginSchema.newContext()

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
    e.preventDefault()
    $button = t.$ e.target
    $button = $button.parent() unless $button.is 'button'
    $button.addClass 'clicked'
    $button.on TRANSITION_END_EVENT, ->
      $button
        .off TRANSITION_END_EVENT
        .removeClass 'clicked'
    $form = t.$ 'form'
    login =
      email: ($form.find '#email').val()
      password: ($form.find '#password').val()
    profile =
      emails: [{address: login.email }]
      createdAt: new Date()
      profile:
        name: $form.find('#name').val()
        forname: $form.find('#forname').val()
        civility: t.rxCivility.get()
    t.userCtx.validate profile
    res = t.userCtx.invalidKeys()
    t.loginCtx.validate login
    res = res.concat t.loginCtx.invalidKeys()
    for r in res
      do ->
        msg = switch r.name
          when 'email' then 'L\'email'
          when 'password' then 'Le mot de passe'
          when 'profile.name'
            r.name = r.name.split('.')[1]
            'Le nom de famille'
          when 'profile.forname'
            r.name = r.name.split('.')[1]
            'Le prénom'
          when 'profile.civility'
            r.name = r.name.split('.')[1]
            'La civilité'
          else 'Un champ'
        $widget = ($form.find "##{r.name}").parent()
        $widget.removeClass 'shake'
        Meteor.setTimeout (-> $widget.addClass 'shake'), 0
        setError "#{msg} #{validationEndErrorMsg r.type}"
    return if res.length > 0
    admin = $form.find('admin').is ':checked'
    Meteor.call 'mCreateUser', login, profile, admin, (e, r) ->
      check(e, Match.Any)
      check(r, Match.Any)
      return setError e.reason if e
      Meteor.setTimeout (-> Router.go 'admin'), 300
