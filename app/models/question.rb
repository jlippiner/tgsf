# == Schema Information
#
# Table name: questions
#
#  id          :integer(4)      not null, primary key
#  question    :string(255)
#  is_personal :boolean(1)      default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

class Question < ActiveRecord::Base
  has_many :answers

  
end
