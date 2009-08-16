class ChangeScreenNameToString < ActiveRecord::Migration
  def self.up
    change_column :followers, :screen_name, :string 
  end

  def self.down
  end
end
