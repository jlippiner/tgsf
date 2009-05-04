class ChangeAnswerToText < ActiveRecord::Migration
  def self.up
    change_column :answers, :answer, :text
  end

  def self.down
  end
end
