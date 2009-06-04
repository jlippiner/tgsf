class ChangeCauseToCampaign < ActiveRecord::Migration
  def self.up
    rename_column :donations, :cause, :campaign
  end

  def self.down
  end
end
