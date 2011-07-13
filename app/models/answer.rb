# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  answer      :text
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :hih_user

  validates_presence_of :answer
end
