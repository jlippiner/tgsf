class ChangeTwitterIdToScreenName < ActiveRecord::Migration
  def self.up
    rename_column :followers, :twitter_id, :screen_name
  end

  def self.down
    rename_column :followers, :screen_name, :twitter_id
  end
end
