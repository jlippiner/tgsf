class CreateUnites < ActiveRecord::Migration
  def self.up
    create_table :unites do |t|
      t.string :name
      t.string :tag

      t.timestamps
    end
  end

  def self.down
    drop_table :unites
  end
end
