require 'active_record'

class User < ActiveRecord::Base

  attr_accessible :name, :surname, :email, :password, :failed_login_count, :terms_of_service, :password_confirmation

  has_many :todo_lists 
  has_many :todo_items, :through => :todo_lists

  validates :name, :length => {:minimum => 1, :maximum => 20}
  validates :name, :surname, :failed_login_count, :password, :presence => true 
  validates :surname, :length => {:minimum => 1, :maximum => 30}
  validates :terms_of_service, :acceptance => true
  validates :password, :confirmation => true, :length => { :minimum => 10} 
  validates :password_confirmation, :presence => true
  validates :email, :format => { :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i }

  def self.find_by_surname(surname)
    where(:surname => surname).first
  end

  def self.find_by_email(email)
    where(:email => email).first
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user.password == password
      return true
    else
       user.update_attributes(:failed_login_count => user.failed_login_count += 1)
      return false
    end
  end

  def is_suspicious
    if self.failed_login_count > 2
      return true
    else
      return false
    end
  end

  def self.find_suspicious_users
    where("failed_login_count > ?", 2) 
  end
  
  def self.find_by_surnames_prefix(prefix)
    where("surname LIKE ?", "#{prefix}%")
  end
  
  def self.find_by_number_of_failed_login_attempts(number)
    where("failed_login_count == ?", number)
  end
end

