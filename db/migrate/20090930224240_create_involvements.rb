class CreateInvolvements < ActiveRecord::Migration
  def self.up
    create_table :involvements do |t|
      t.boolean :is_featured
      t.string :title
      t.text :body
      t.string :dates
      t.boolean :is_active

      t.timestamps
    end
  end

  def self.down
    drop_table :involvements
  end
end
