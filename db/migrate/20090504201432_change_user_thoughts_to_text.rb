class ChangeUserThoughtsToText < ActiveRecord::Migration
  def self.up
    change_column :users, :thoughts, :text
  end

  def self.down
  end
end
