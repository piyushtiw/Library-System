class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_type, default: 0
      t.integer :status
      t.integer :university_id
      t.integer :library_id
      t.integer :education_level
      t.integer :active_status, default: 0
      t.timestamps
    end
  end
end
