class ChangeToBoolean < ActiveRecord::Migration
  def self.up
    remove_column :involvements, :is_featured
    remove_column :involvements, :is_active
    remove_column :donations, :highlight
    
    add_column :donations, :highlight, :boolean
    add_column :involvements, :is_active, :boolean
    add_column :involvements, :is_featured, :boolean
    
    Involvement.update_all "is_active = true, is_featured = true", "dates = 'In process'"
  end

  def self.down
    add_column :donations, :highlight, :boolean
    add_column :involvements, :is_active, :boolean
    add_column :involvements, :is_featured, :boolean
  end
end
