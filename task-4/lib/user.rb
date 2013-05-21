require 'active_record'

class User < ActiveRecord::Base
  has_many :todolists, 
  has_many :todoitems, :through => :todolists
  validates :name, :less_than_or_equal_to => :20
  validates :name, :surname, :failed_login_count, :password, :presence 
=> true 
  validates :surname, :less_than_or_equal_to => :30
  validates :terms_of_service, :acceptance => {:accept => 'yes'}
  validates :password, :confirmation => true, :greater_than_or_equal_to 
=> :10 
  validates :email, :format => { with => 
/\A[\w]{4,15}@[A-Za-z0-9]{2,8}.[\s]{2,3}\z/}
end





