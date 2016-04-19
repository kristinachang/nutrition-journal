class CreateJoinTableDailyItem < ActiveRecord::Migration
  def change
    create_join_table :dailies, :items do |t|
      t.index [:daily_id, :item_id]
      t.index [:item_id, :daily_id]
    end
  end
end
