class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.integer :height
      t.integer :weight
      t.string :activity_level

      t.timestamps null: false
      t.references :user
    end
  end
end
