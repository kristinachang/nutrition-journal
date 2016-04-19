class CreateDailies < ActiveRecord::Migration
  def change
    create_table :dailies do |t|
      t.date :date
      t.datetime :date_eaten
      t.integer :mood
      t.string :notes
      t.integer :morning_total
      t.integer :midday_total
      t.integer :evening_total
      t.integer :day_total

      t.timestamps null: false
      t.references :user
    end
  end
end
