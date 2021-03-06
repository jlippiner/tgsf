# == Schema Information
#
# Table name: unite_donations
#
#  id            :integer         not null, primary key
#  unite_id      :integer
#  amount        :float
#  first_name    :string(255)
#  last_name     :string(255)
#  donation_type :string(255)
#  message       :string(255)
#  donated_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

class UniteDonation < ActiveRecord::Base
  belongs_to :unite
  
  validates_presence_of :amount, :first_name, :last_name, :donated_at, :donation_type
end
