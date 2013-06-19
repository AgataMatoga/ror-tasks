require_relative 'test_helper'
require_relative '../lib/todo_list'
require_relative '../lib/user'
require_relative '../lib/todo_item'

describe TodoList do
  include TestHelper

  before(:each) do
    @valid_attributes = {
      :title => "Lista do zrobienia",
      :user_id => "2",
     }
  end

  it "should save list with valid attributes" do
    valid_list = TodoList.new(@valid_attributes)
    valid_list.save
    valid_list.should be_valid
  end

  it "should have a non-empty title" do
    empty_title = TodoList.new(@valid_attributes.merge(:title => ""))
    empty_title.should_not be_valid
  end

  it "should have a non-empty user it belongs to" do
    empty_user = TodoList.new(@valid_attributes.merge(:user_id => ""))
    empty_user.should_not be_valid
  end
  
  it "should find list by prefix of the title" do
    todo_lists = TodoList.find_by_title_prefix('l')
    todo_lists.count.should == 3
  end 
  
  it "should find all lists that belong to a given User" do
    user = User.find_by_email("Jan.Nowak@op.pl")
    todo_lists = TodoList.find_by_user(user)
    todo_lists.count.should == 1
  end
  
  it "should find list by id eagerly loading its ListItems" do
    todo_list_items = TodoList.find_items(1)
    todo_list_items.count.should == 2
  end
  
end

