class CreatePresses < ActiveRecord::Migration
  def self.up
    create_table :presses do |t|
      t.string :item
      t.string :source
      t.date :story_date_at
      t.string :link
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :presses
  end
end
