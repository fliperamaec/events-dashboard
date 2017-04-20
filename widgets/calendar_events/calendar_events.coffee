class Dashing.CalendarEvents extends Dashing.Widget

  MONTHS = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ]

  onData: (data) =>
    if intervalId?
      clearInterval(intervalId)

    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    getEvents data.events.items...

    start = moment(event.start.date_time)
    end = moment(event.end.date_time)

    @set('main_event', event)
    @set('event_date', start.format('DD/MM'))
    @set('event_time', start.format('HH:mm'))

    months = []
    for nextEvent in rest
      newEventStart = moment(nextEvent.start.date_time)
      newEventStartDate = newEventStart.format('DD/MM')
      newEventStartTime = newEventStart.format('HH:mm')
      newEventMonth = newEventStart.month()
      currentMonth = months.find((m) -> m.id == newEventMonth)

      if !currentMonth
        currentMonth = { id: newEventMonth, name: MONTHS[newEventMonth], next_events: [] }
        months.push(currentMonth)

      if currentMonth['next_events'].length < 5
        eventAttrs = { summary: nextEvent.summary, start_date: newEventStartDate, start_time: newEventStartTime }
        currentMonth['next_events'].push(eventAttrs)

    @set('months', months.slice(0, 2))

    initialCountdown = start.valueOf() - moment.now()
    duration = moment.duration(initialCountdown)
    interval = 1000
    $timer = $('.js-countdown-timer')
    $mainEventArea = $('.js-main-event')

    intervalId = setInterval ->
      if duration < interval
        $timer.text('UHUU! :D')
        clearInterval(intervalId)
      else
        duration = moment.duration(duration - interval, 'milliseconds')
        data = duration._data
        hours = data['hours'] + 24 * data['days']
        minutesAndSeconds = moment(data).format('mm:ss')

        $timer.text("#{hours}:#{minutesAndSeconds}")
        $mainEventArea.toggleClass('today', hours < 24)
    , interval
