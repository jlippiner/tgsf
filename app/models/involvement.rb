# == Schema Information
#
# Table name: involvements
#
#  id                :integer(4)      not null, primary key
#  is_featured       :boolean(1)
#  title             :string(255)
#  body              :text
#  dates             :string(255)
#  is_active         :boolean(1)
#  created_at        :datetime
#  updated_at        :datetime
#  short_name        :string(255)
#  partial_file_name :string(255)
#  campaign          :string(255)
#

class Involvement < ActiveRecord::Base
  validates_presence_of :title
  validates_format_of :short_name, :with => /^[A-Za-z\d_]+$/
  # validates_format_of :short_name, :with => /^[^\d].+$/, :message => "cannot start with a number"
  
  before_save :downcase_short_name
  
  private
  
  def downcase_short_name
    short_name.downcase!
  end
  
  
  
end
