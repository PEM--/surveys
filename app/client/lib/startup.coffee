Meteor.startup ->
  # Animate page transitions
  _enterAnimation = 'fadeIn'
  _leaveAnimation = 'fadeOut'
  _animate = ($el, anim, next) ->
    $el.addClass(anim).on ANIMATION_END_EVENT, ->
      $(this).removeClass anim
      next and next()
  Router.onAfterAction ->
    _animate $('section'), _enterAnimation
