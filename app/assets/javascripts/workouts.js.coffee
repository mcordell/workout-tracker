new_set_count = 0

ready = ->
  $('button#quick-add').click( (event) ->
    appendSet()
    event.preventDefault())

appendSet = ->
  row = $('#new-workout-set-template tbody').html()
  new_row = row.replace(/new_set_id/g, new_set_count++)
  $('tbody#sets').append(new_row)

$(document).ready(ready)
$(document).on('page:load', ready)
