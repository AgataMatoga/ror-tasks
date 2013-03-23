require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'

describe TodoList do
  subject(:list)            { TodoList.new(items) }
  let(:items)               { [] }
  let(:item_description)    { "Buy toilet paper" }

  it { should be_empty }

  it "should raise an exception when nil is passed to the constructor" do
    expect { TodoList.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should have size of 0" do
    list.size.should == 0
  end

  it "should accept an item" do
    list << item_description
    list.should_not be_empty
  end

  it "should add the item to the end" do
    list << item_description
    list.last.to_s.should == item_description
  end

  it "should have the added item uncompleted" do
    list << item_description
    list.completed?(0).should be_false
  end

  context "with one item" do
    let(:items)             { [item_description] }

    it { should_not be_empty }

    it "should have size of 1" do
      list.size.should == 1
    end

    it "should have the first and the last item the same" do
      list.first.to_s.should == list.last.to_s
    end

    it "should not have the first item completed" do
      list.completed?(0).should be_false
    end

    it "should change the state of a completed item" do
      list.complete(0)
      list.completed?(0).should be_true
    end
  end

  context "with four items" do 
    let(:items) { ["Zakupy" , "Sprzatanie", "Wyprowadzic psy na spacer", "Zrobic obiad"] }

    before:each do 
      list.complete(1)
      list.complete(3)
    end

    it "should return completed items" do
       list.completed.should == ["Sprzatanie", "Zrobic obiad"]
    end

    it "should return uncompleted items" do
      list.uncompleted.should == ["Zakupy", "Wyprowadzic psy na spacer"]
    end  

   it "should revert two items" do
      list.revert_two(1,2)
      list.items[1].to_s.should == "Wyprowadzic psy na spacer"
      list.items[2].to_s.should == "Sprzatanie"
    end  

   it "should revert all items" do
      list.revert_all
      list.items[0].to_s.should == "Zrobic obiad"
      list.items[1].to_s.should == "Wyprowadzic psy na spacer"
      list.items[2].to_s.should == "Sprzatanie"
      list.items[3].to_s.should == "Zakupy"
    end  

    it "should remove an items" do
      list.remove(0)
      list.items[0].to_s.should == "Sprzatanie"
    end 

   it "should remove completed items" do
      list.remove_completed
      list.completed.should be_empty
    end 

   it "should toggle an item state" do
      list.toggle_item(1)
      list.items[1].completed.should == false
    end

   it "should change the state to uncompleted" do
      list.change_to_uncompleted(3)
      list.items[3].completed.should == false
    end

   it "should change the description of an item" do
      list.change_description(0, "Zmieniony")
      list.items[0].to_s.should == "Zmieniony"
   end
   
   it "should sort items by name" do
      list.sort
      list.items[0].to_s.should == "Sprzatanie"
      list.items[1].to_s.should == "Wyprowadzic psy na spacer" 
      list.items[2].to_s.should == "Zakupy" 
      list.items[3].to_s.should == "Zrobic obiad"
   end

   it "should convert the list of items to text" do
      list.convert_to_text.should == "[ ] Zakupy\n[x] Sprzatanie\n[ ] Wyprowadzic psy na spacer\n[x] Zrobic obiad"
   end

  end
end
