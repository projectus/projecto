json.array!(@news_posts) do |news_post|
  json.extract! news_post, :content, :title, :type, :project_id, :user_id
  json.url news_post_url(news_post, format: :json)
end
