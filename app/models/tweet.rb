# == Schema Information
# Schema version: 20090805184853
#
# Table name: tweets
#
#  id                  :integer(4)      not null, primary key
#  zipcode             :string(255)
#  twitter_id          :string(255)
#  sent_dm             :boolean(1)
#  is_following        :boolean(1)
#  number_of_friends   :integer(4)
#  number_of_followers :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#

class Tweet < ActiveRecord::Base
end
