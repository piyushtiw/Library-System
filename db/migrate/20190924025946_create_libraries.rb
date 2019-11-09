class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :location
      t.integer :fine
      t.integer :university_id
      t.integer :max_borrow_days
      t.integer :overdue_fines
      t.boolean :library_status
      t.integer :active_status, default: 0
      t.timestamps
    end
  end
end
