require_relative 'test_helper'
require_relative '../lib/todo_list'

describe TodoList do
  include TestHelper

  before(:each) do
    @valid_attributes = {
      :title => "Lista do zrobienia",
      :user_id => "2",
     }
  end

  it "should save list with valid attributes" do
    valid_list = TodoIList.new(@valid_attributes)
    valid_list.save
    valid_list.should be_valid
  end

  it "should have a non-empty title" do
    empty_title = TodoIList.new(@valid_attributes.merge(:title => ""))
    empty_title.should_not be_valid
  end

  it "should have a non-empty user it belongs to" do
    empty_user = TodoList.new(@valid_attributes.merge(:user_id => ""))
    empty_user.should_not be_valid
  end
  
end

