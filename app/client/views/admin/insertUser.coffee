Template.insertUser.events
  submit: (e) ->
    console.log e
    e.preventDefault()

    #Router.go '/admin'

  'focus input[type=\'email\'], \
    focus input[type=\'password\'], \
    focus input[type=\'text\']': (e, t) ->
    (t.$ e.target).addClass 'filled'
  'blur input[type=\'email\'], \
    blur input[type=\'password\'], \
    blur input[type=\'text\']': (e, t) ->
    (t.$ e.target).removeClass 'filled' if e.target.value.length is 0
  'focus .select-custom': (e, t) ->
    (t.$ 'p').addClass 'filled'
  'blur .select-custom': (e, t) ->
    $p = t.$ 'p'
    $p.removeClass 'filled' if $p.text().length is 0


Template.insertUser.helpers
  civility: ->
    UserSchema.schema()['profile.civility'].allowedValues
  selectedCivility: -> ''
