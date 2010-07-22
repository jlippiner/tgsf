class AddShortNameAndPartialFileNameToInvolvements < ActiveRecord::Migration
  def self.up
    add_column :involvements, :short_name, :string
    add_column :involvements, :partial_file_name, :string
  end

  def self.down
    remove_column :involvements, :partial_file_name
    remove_column :involvements, :short_name
  end
end
