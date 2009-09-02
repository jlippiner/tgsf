# == Schema Information
#
# Table name: unite_donations
#
#  id         :integer(4)      not null, primary key
#  uniter_id  :integer(4)
#  amount     :float
#  first_name :string(255)
#  last_name  :string(255)
#  type       :string(255)
#  message    :string(255)
#  donated_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class UniteDonation < ActiveRecord::Base
  belongs_to :unite
  
  validates_presence_of :amount, :first_name, :last_name, :donated_at, :donation_type
end
