require 'active_record/fixtures'

class LoadQuestionsData < ActiveRecord::Migration
  def self.up
    down

    directory = File.join(File.dirname(__FILE__), 'data')
    Fixtures.create_fixtures(directory, "questions")
  end

  def self.down
    Question.delete_all
  end
end
