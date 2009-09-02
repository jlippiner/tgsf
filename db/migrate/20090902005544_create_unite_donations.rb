class CreateUniteDonations < ActiveRecord::Migration
  def self.up
    create_table :unite_donations do |t|
      t.integer :unite_id
      t.float :amount
      t.string :first_name
      t.string :last_name
      t.string :type
      t.string :message
      t.datetime :donated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :unite_donations
  end
end
