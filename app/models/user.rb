class User < ActiveRecord::Base
  has_many :answers

  validates_presence_of :email, :name, :disease
  validates_format_of  :email,
    :with       => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message    => 'email must be valid'
end
