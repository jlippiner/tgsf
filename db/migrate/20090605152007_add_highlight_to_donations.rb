class AddHighlightToDonations < ActiveRecord::Migration
  def self.up
    add_column :donations, :highlight, :boolean
  end

  def self.down
    remove_column :donations, :highlight
  end
end
