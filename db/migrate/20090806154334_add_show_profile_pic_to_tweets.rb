class AddShowProfilePicToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :profile_pic_url, :string
  end

  def self.down
    remove_column :tweets, :profile_pic_url
  end
end
