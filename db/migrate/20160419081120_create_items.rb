class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.date :date
      t.time :time
      t.datetime :time_eaten
      t.string :name
      t.string :ndbno
      t.string :protein
      t.string :fat
      t.string :carb
      t.string :kcal
      t.string :unit
      t.integer :mood
      t.string :notes

      t.timestamps null: false
    end
  end
end
