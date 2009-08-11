# == Schema Information
# Schema version: 20090620001551
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  name                :string(255)
#  email               :string(255)
#  survey_number       :integer(4)
#  thoughts            :text
#  created_at          :datetime
#  updated_at          :datetime
#  disease             :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#  diagnosis_month     :integer(4)
#  diagnosis_year      :integer(4)
#  relation_to_disease :string(255)
#

class HihUser < ActiveRecord::Base
  has_many :answers, :dependent => :destroy

  validates_presence_of :email, :name, :disease, :diagnosis_month, :diagnosis_year, :relation_to_disease
  validates_format_of  :email,
    :with       => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message    => 'email must be valid'

     # Paperclip
  has_attached_file :avatar,
    :url => "/:class/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension",
    :default_url => "/images/missing.png",
    :whiny_thumbnails => true,
    :styles => {
    :thumb => "100x100#",
    :tiny => "50x50>",
    :medium => "75x75>"
  },
    :default_style => :thumb,
    :convert_options => {
    :thumb => "-border 5 -frame 3x3",
    :tiny => "-border 5 -frame 3x3",
    :medium => "-border 2 -frame 1x1"
    }
end
