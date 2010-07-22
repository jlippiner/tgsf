class AddCampaignToInvolvements < ActiveRecord::Migration
  def self.up
    add_column :involvements, :campaign, :string
  end

  def self.down
    remove_column :involvements, :campaign
  end
end
