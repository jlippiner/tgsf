class AddDiseaseToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :disease, :string
  end

  def self.down
  end
end
