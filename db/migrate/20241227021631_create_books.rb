class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.text :synopsis
      t.float :rating
      t.string :cover_image
      t.string :file_path
      t.integer :availability_status

      t.timestamps
    end
  end
end
