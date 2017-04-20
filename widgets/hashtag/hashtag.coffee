class Dashing.Hashtag extends Dashing.Widget

  ready: ->
    setInterval ->
      $('.js-calendar-events').toggle()
      $('.js-hashtag').toggle()
    , 30000
