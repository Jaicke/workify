var EVENTS = (function(events){
  'use strict'

  var initializerCalendar = function(){
    let urlEvents = $('input#url-events')[0]
    if (urlEvents == null){
      return
    }

    $('#calendar').fullCalendar({
      defaultView: 'month',
      locale: 'pt-br',
      timeZone: 'America/Recife',
      timeFormat: 'HH:mm',
      nowIndicator: true,
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,listMonth'
      },
      events: {
        url: `${urlEvents.value}.json`
      }
    });
  }

  var togglePlaceField = function(){
    $('body').on('change', '#event_online', function(){
      toggleFields()
    })
  }

  var toggleFields = function(){
    let groupCheck = $('#event_online')
    let placeField = $('#place-field')
    let roomField = $('#room-field')

    if (groupCheck.is(":checked")){
      roomField.show()
      placeField.hide()
    } else {
      roomField.hide()
      placeField.show()
    }
  }

  var events = {
    init: function(){
      initializerCalendar()
      togglePlaceField()
    }
  }

  return events
}(EVENTS || {}))

$(document).on('ready turbolinks:load', function(){
  EVENTS.init()
})
