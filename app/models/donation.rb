class Donation < ActiveRecord::Base
  named_scope :for_campaign, lambda  { |val| {:conditions => ["campaign = ?", val] }}
  named_scope :highlighted, :conditions => "highlight = true"
  named_scope :not_highlighted, :conditions => "highlight is null OR highlight = false"

  validates_presence_of :name, :location, :amount, :campaign
end
