class CreateUniters < ActiveRecord::Migration
  def self.up
    create_table :uniters do |t|
      t.string :name
      t.string :tag

      t.timestamps
    end
  end

  def self.down
    drop_table :uniters
  end
end
