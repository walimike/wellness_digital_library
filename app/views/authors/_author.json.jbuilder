json.extract! author, :id, :name, :bio, :avatar_url, :created_at, :updated_at
json.url author_url(author, format: :json)
