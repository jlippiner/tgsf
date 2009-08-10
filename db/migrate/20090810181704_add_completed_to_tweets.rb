class AddCompletedToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :completed, :boolean
  end

  def self.down
    remove_column :tweets, :completed
  end
end
