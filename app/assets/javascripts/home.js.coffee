$ ->
  container = $('.items')
  return if !container.length

  item = $('.item:first')
  coverWidth = +item.css('width').replace(/[^\d]+/, '')
  coverMargin = +item.css('margin-right').replace(/[^\d]+/, '')

  resize = ->
    bodyWidth = $('body').width()
    w = coverWidth + coverMargin
    width = Math.floor(bodyWidth / w) * w
    container.css 'width', width

  $(window).on 'resize', resize
  resize()
