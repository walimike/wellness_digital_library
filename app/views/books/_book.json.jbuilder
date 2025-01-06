json.extract! book, :id, :title, :author, :genre, :synopsis, :rating, :cover_image, :file_path, :availability_status, :created_at, :updated_at
json.url book_url(book, format: :json)
