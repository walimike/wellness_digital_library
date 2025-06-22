class CreateBookPurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :book_purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :stripe_session_id
      t.boolean :paid

      t.timestamps
    end
  end
end
