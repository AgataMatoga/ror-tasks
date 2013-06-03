
require_relative 'test_helper'
require_relative '../lib/user'

describe User do
  include TestHelper

  before(:each) do
    @valid_attributes = {
      :id => 3,
      :name => 'Joanna',
      :surname => 'Kowalska',
      :password => 'joasia19love',
      :email => 'asia1989@gmail.com',
      :failed_login_count => 1,
      :terms_of_service => "1",
      :password_confirmation => 'joasia19love'
    }
  end

 it "should save user with valid attributes" do
   valid_user = User.new(@valid_attributes)
   valid_user.save
   p valid_user
   valid_user.should be_valid 
 end


  it "should have a non-empty name" do
    empty_name = User.new(@valid_attributes.merge(:name => ""))
    empty_name.should_not be_valid
  end

  it "should have a name up to 20 characters long" do
    too_long_name = User.new(@valid_attributes.merge(:name => "kontantynopolitaczykkiewiczna"))
    too_long_name.should_not be_valid
  end

  it "should have a non-empty surname" do
    empty_surname = User.new(@valid_attributes.merge(:surname => ""))
    empty_surname.should_not be_valid
  end

  it "should have a surname up to 30 characters long" do
    too_long_surname = User.new(@valid_attributes.merge(:surname => "caygdrfuygeufsueygrfuyegrfeurygfuyegrfugyeurygfeurygfuewygrufw"))
    too_long_surname.should_not be_valid
  end

  it "should have a valid email address" do
    not_valid_email = User.new(@valid_attributes.merge(:email => "asia.gmail.com"))
    not_valid_email.should_not be_valid
  end

  it "should accepts the terms of the service" do
    wrong_terms_of_service = User.new(@valid_attributes.merge(:terms_of_service => 0))
    wrong_terms_of_service.should_not be_valid
  end

  it "should have a non-empty password" do
    empty_password = User.new(@valid_attributes.merge(:password => ""))
    empty_password.should_not be_valid
  end

  it "should have a password that is at least 10 characters long" do
    too_short_password = User.new(@valid_attributes.merge(:password => "aga"))
    too_short_password.should_not be_valid
  end

  it "should have confirmed his/her password" do
    wrong_password_confirmation = User.new(@valid_attributes.merge(:password_confirmation => "joasialalal"))
    wrong_password_confirmation.should_not be_valid 
  end

  it "should have non-empty integer failed_login_count" do
    empty_failed_login_count = User.new(@valid_attributes.merge(:failed_login_count => ""))
    empty_failed_login_count.should_not be_valid  
  end

  it "should find user by surname" do
    
  end 

end


