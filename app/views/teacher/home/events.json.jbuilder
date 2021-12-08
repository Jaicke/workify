json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :color
  json.start event.event_date
  # json.color 'yellow'
  # json.textColor 'black'
  json.url teacher_event_path(id: event.id, work_id: event.work.id)
end
