# == Schema Information
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

require 'test_helper'

class DonationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
