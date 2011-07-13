# == Schema Information
#
# Table name: tweets
#
#  id                  :integer         not null, primary key
#  zipcode             :string(255)
#  twitter_id          :string(255)
#  sent_dm             :integer(2)
#  is_following        :integer(2)
#  number_of_friends   :integer
#  number_of_followers :integer
#  created_at          :datetime
#  updated_at          :datetime
#  profile_pic_url     :string(255)
#  completed           :integer(2)
#

require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
