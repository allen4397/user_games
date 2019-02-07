class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password

  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :password

  def self.authenticate(email, password)
    find_by(email: email, password: password)
  end
end
