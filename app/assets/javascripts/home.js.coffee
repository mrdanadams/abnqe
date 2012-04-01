$ ->
  container = $('.items')
  return if !container.length

  # sizing
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

  # search
  items = $('.item')
  $('#q').on 'keyup', ->
    container.removeClass 'filtered-no-results'

    q = $(this)
    search = q.val().trim().replace(/[^\w\s]+/, '')
    if !search.length
      container.removeClass 'filtered'
      return

    r = new RegExp search, 'i'
    $('.hit', container).removeClass 'hit'
    container.addClass 'filtered'

    found = false
    items.each ->
      title = $(this).attr('data-title')
      if title.match r
        $(this).addClass 'hit'
        found = true

      true

    if !found
      container.addClass 'filtered-no-results'

  # cancel submit events
  $('.navbar form').bind 'submit', -> false