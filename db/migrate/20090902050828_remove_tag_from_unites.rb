class RemoveTagFromUnites < ActiveRecord::Migration
  def self.up
    remove_column :unites, :tag 
  end

  def self.down
  end
end
