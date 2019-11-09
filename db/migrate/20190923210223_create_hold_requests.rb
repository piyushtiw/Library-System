class CreateHoldRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :hold_requests do |t|
      t.references :user
      t.references :book
      t.references :library
      t.string :request_type #Make this an enum
      t.integer :permission
      t.timestamps
    end
  end
end
