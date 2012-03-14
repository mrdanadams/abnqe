$ ->
  container = $('.items')
  return if !container.length
  
  coverWidth = 110
  coverMargin = 10

  resize = ->
    bodyWidth = $('body').width()
    w = coverWidth + coverMargin
    width = Math.floor(bodyWidth / w) * w
    container.css 'width', width

  $(window).on 'resize', resize
  resize()
