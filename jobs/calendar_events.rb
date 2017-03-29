require 'google/apis/calendar_v3'
require 'googleauth'
require 'date'

SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']

SCHEDULER.every '15m', first_in: 4 do |job|
  service = Google::Apis::CalendarV3::CalendarService.new
  service.authorization = Google::Auth.get_application_default(SCOPES)

  result = service.list_events(
    ENV['GOOGLE_CALENDAR_ID'],
    max_results: 15,
    single_events: true,
    order_by: 'startTime',
    time_max: (Time.now.to_datetime >> 3).rfc3339,
    time_min: Time.now.to_datetime.rfc3339
  )

  send_event('calendar_events', { events: result.to_h })
end
