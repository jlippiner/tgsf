class ChangeTypeToDonationTypeInUniteDonation < ActiveRecord::Migration
  def self.up
    rename_column :unite_donations, :type, :donation_type
  end

  def self.down
    rename_column :unite_donations, :donation_type, :type
  end
end
