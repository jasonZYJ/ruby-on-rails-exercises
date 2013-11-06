$ ->
  $('[data-select~=brand]').change (event) ->
    brand_id = $(event.target).val()
    $.get "/brands/#{brand_id}/frames.json", (data) ->
      options = ''
      if data.length == 0
        options = '<option>No frames for that brand</option>'
      else
        for frame in data
          options += "<option value='#{frame.id}'>#{frame.name}</option>"

      $('[data-select~=frame]').html(options)
