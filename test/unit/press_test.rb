# == Schema Information
#
# Table name: presses
#
#  id            :integer(4)      not null, primary key
#  item          :string(255)
#  source        :string(255)
#  story_date_at :date
#  link          :string(255)
#  comment       :text
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class PressTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
