class CreateFollowers < ActiveRecord::Migration
  def self.up
    create_table :followers do |t|
      t.integer :twitter_id
      t.integer :friend_id

      t.timestamps
    end
  end

  def self.down
    drop_table :followers
  end
end
