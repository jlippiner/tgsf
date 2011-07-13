# == Schema Information
#
# Table name: questions
#
#  id          :integer         not null, primary key
#  question    :string(255)
#  is_personal :integer(2)
#  created_at  :datetime
#  updated_at  :datetime
#

class Question < ActiveRecord::Base
  has_many :answers

  
end
