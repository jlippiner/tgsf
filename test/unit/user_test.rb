# == Schema Information
#
# Table name: users
#
#  id                           :integer(4)      not null, primary key
#  twitter_id                   :string(255)
#  login                        :string(255)
#  access_token                 :string(255)
#  access_secret                :string(255)
#  remember_token               :string(255)
#  remember_token_expires_at    :datetime
#  name                         :string(255)
#  location                     :string(255)
#  description                  :string(255)
#  profile_image_url            :string(255)
#  url                          :string(255)
#  protected                    :boolean(1)
#  profile_background_color     :string(255)
#  profile_sidebar_fill_color   :string(255)
#  profile_link_color           :string(255)
#  profile_sidebar_border_color :string(255)
#  profile_text_color           :string(255)
#  profile_background_image_url :string(255)
#  profile_background_tiled     :boolean(1)
#  friends_count                :integer(4)
#  statuses_count               :integer(4)
#  followers_count              :integer(4)
#  favourites_count             :integer(4)
#  utc_offset                   :integer(4)
#  time_zone                    :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
