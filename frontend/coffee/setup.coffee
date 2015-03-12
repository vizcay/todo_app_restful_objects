$ =>
  _.templateSettings = { interpolate: /\{\{(.+?)\}\}/g }

  $(document).ajaxSend (event, xhr, settings) ->
    $('#modal-ajax-wait').modal('show')
    app.logs.push { type: 'request', method: settings.type, url: settings.url, data: settings.data }

  $(document).ajaxComplete (event, xhr, settings) ->
    app.logs.push { type: 'response', data: xhr.responseText }
    $('#modal-ajax-wait').modal('hide')
