require 'test_helper'

class 200kForSMATest < ActiveSupport::TestCase
  def test_should_be_valid
    assert 200kForSMA.new.valid?
  end
end
