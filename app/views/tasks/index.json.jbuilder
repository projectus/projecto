json.array!(@tasks) do |task|
  json.extract! task, :title, :details, :priority, :status, :poster_id
  json.url task_url(task, format: :json)
end
