class CreateCheckOutLists < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :book
      t.references :library
      t.datetime :returned_on
      t.integer :paid_fine
      t.timestamps
    end
  end
end
