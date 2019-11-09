class CreateUniversities < ActiveRecord::Migration[5.2]
  def change
    create_table :universities do |t|
      t.string :name
      t.integer :active_status, default: 0

      t.timestamps
    end
  end
end
