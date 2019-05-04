class User < ApplicationRecord
  belongs_to :role
  has_secure_password
  
  def self.by_email(email)
    find_by_email(email)
  end
end
