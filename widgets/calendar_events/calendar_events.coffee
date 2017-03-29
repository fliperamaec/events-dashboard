class Dashing.CalendarEvents extends Dashing.Widget

  if intervalId?
    clearInterval(intervalId)

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

      eventAttrs = { summary: nextEvent.summary, start_date: newEventStartDate, start_time: newEventStartTime }
      currentMonth['next_events'].push(eventAttrs)

    @set('months', months.slice(0, 2))

    initialCountdown = start.valueOf() - moment.now()
    duration = moment.duration(initialCountdown)
    interval = 1000
    $timer = $('.js-countdown-timer')

    intervalId = setInterval ->
      if duration < interval
        $timer.text('UHUU! :D')
        clearInterval(intervalId)
      else
        duration = moment.duration(duration - interval, 'milliseconds')
        countdown = moment(duration._data).format('HH:mm:ss')
        $timer.text(countdown)
    , interval
