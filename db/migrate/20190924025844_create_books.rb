class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :isbn
      t.integer :number_of_copies
      t.string :authors
      t.string :language
      t.datetime :published_date
      t.string :edition
      t.string :subject
      t.string :summary
      t.boolean :special_collection, default: 0
      t.boolean :book_status
      t.integer :available_books
      t.timestamps
      t.references :library
      t.integer :active_status, default: 0
    end
  end
end
