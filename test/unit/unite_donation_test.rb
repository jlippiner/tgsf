# == Schema Information
#
# Table name: unite_donations
#
#  id            :integer(4)      not null, primary key
#  unite_id      :integer(4)
#  amount        :float
#  first_name    :string(255)
#  last_name     :string(255)
#  donation_type :string(255)
#  message       :string(255)
#  donated_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class UniteDonationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
