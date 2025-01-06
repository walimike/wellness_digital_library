class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :bio
      t.string :avatar_url

      t.timestamps
    end
  end
end
