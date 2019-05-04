class User < ApplicationRecord
  belongs_to :role
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_presence_of :name,:lastname,:password, presence: true
  validates_length_of :name,:lastname,:email, within: 3..30
  validates_length_of :password, within: 8..50

  def self.by_email(email)
    find_by_email(email)
  end
  
end
