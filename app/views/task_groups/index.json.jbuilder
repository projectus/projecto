json.array!(@task_groups) do |task_group|
  json.extract! task_group, :name
  json.url task_group_url(task_group, format: :json)
end
