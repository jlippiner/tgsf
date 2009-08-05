# == Schema Information
# Schema version: 20090620001551
#
# Table name: answers
#
#  id          :integer(4)      not null, primary key
#  answer      :text
#  question_id :integer(4)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates_presence_of :answer
end
