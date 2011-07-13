# == Schema Information
#
# Table name: involvements
#
#  id                :integer         not null, primary key
#  title             :string(255)
#  body              :text
#  dates             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  short_name        :string(255)
#  partial_file_name :string(255)
#  campaign          :string(255)
#  is_active         :boolean
#  is_featured       :boolean
#

require 'test_helper'

class InvolvementTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
