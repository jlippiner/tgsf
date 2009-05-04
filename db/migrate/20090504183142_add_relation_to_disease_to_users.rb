class AddRelationToDiseaseToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :relation_to_disease, :string
  end

  def self.down
     remove_column :users, :relation_to_disease
  end
end
