# == Schema Information
#
# Table name: followers
#
#  id          :integer         not null, primary key
#  screen_name :string(255)
#  friend_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class FollowerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
