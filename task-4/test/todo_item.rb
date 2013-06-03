require_relative 'test_helper'
require_relative '../lib/todo_item'

describe User do
  include TestHelper

  before(:each) do
    @valid_attributes = {
      :title => "Zakupy",
      :list_id => "2",
      :description => 'Idz do kauflanda i kup kilo ziemniaków',
      :due_date => '03/06/2013'
     }
  end

  it "should save list with valid attributes" do
    valid_item = TodoIList.new(@valid_attributes)
    valid_item.save
    valid_item.should be_valid
  end

  it "should have a non-empty title" do
    empty_title = TodoItem.new(@valid_attributes.merge(:title => ""))
    empty_title.should_not be_valid
  end

  it "should have a title which is less than 30 characters long" do
    too_long_title = TodoItem.new(@valid_attributes.merge(:title => "kontantynopolitaczykkiewicznajchgsdkfghvjsudgbfjvhbsdjgvhbsjdfgbvsdfbvhdfad"))
    too_long_title.should_not be_valid
  end
  
  it "should have a title which more than 5 characters long" do
    too_short_title = TodoItem.new(@valid_attributes.merge(:title => "ab"))
    too_short_title.should_not be_valid
  end

  it "should have a non-empty list it belongs to" do
    empty_list_id = TodoItem.new(@valid_attributes.merge(:list_id => ""))
    empty_list_id.should_not be_valid
  end

  it "should have a description up to 255 characters long that might be empty" do
    too_long_description = TodoItem.new(@valid_attributes.merge(:description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
    too_long_descriprion.should_not be_valid
  end

  it "should have a due date in dd/mm/yyyy format, that might be empty" do
    wrong_date_format = TodoItem.new(@valid_attributes.merge(:due_date => "13.05.2014"))
    wrong_date_format.should_not be_valid
  end

end


