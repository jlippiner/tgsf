# == Schema Information
# Schema version: 20090620001551
#
# Table name: donations
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  campaign      :string(255)
#  location      :string(255)
#  donation_date :datetime
#  amount        :integer(10)
#  created_at    :datetime
#  updated_at    :datetime
#  highlight     :boolean(1)
#

class Donation < ActiveRecord::Base
  named_scope :for_campaign, lambda  { |val| {:conditions => ["campaign = ?", val] }}
  named_scope :highlighted, :conditions => "highlight = true"
  named_scope :not_highlighted, :conditions => "highlight is null OR highlight = false"

  validates_presence_of :name, :location, :amount, :campaign
end
