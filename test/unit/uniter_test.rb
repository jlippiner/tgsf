# == Schema Information
#
# Table name: uniters
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  tag        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class UniterTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
