class AddDiagnosisDateInformationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :diagnosis_month, :integer
    add_column :users, :diagnosis_year, :integer
  end

  def self.down
    remove_column :users, :diagnosis_month
    remove_column :users, :diagnosis_year
  end
end
