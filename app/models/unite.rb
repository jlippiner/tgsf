# == Schema Information
#
# Table name: unites
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  tag        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Unite < ActiveRecord::Base
  has_many :unite_donations, :order => "donated_at DESC"
  
  validates_presence_of :name
end
