class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.string :name
      t.string :cause
      t.string :location
      t.datetime :donation_date
      t.decimal :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :donations
  end
end
