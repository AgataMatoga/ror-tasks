class TodoList
  attr_accessor :items

  class Item
    attr_accessor :desc, :completed
  
    def initialize(item)
      @desc = item
      @completed = false
    end  

    def to_s
      @desc
    end
  end

  # Initialize the TodoList with +items+ (empty by default).
  
  def initialize(items=[])
    if items.nil?
      raise IllegalArgument.new
    else
      @items = []
    
      items.each do |item|
        @items << Item.new(item)
      end
    
    end
  end

  def size
    @items.size
  end

  def empty?
    @items.empty?
  end

  def <<(new_item)
    @items << Item.new(new_item)
  end

  def last
    @items.last
  end

  def first
    @items.first
  end
  
  def completed?(id)
    @items[id].completed
  end
  
  def complete(id)
    @items[id].completed = true
  end

  def completed
    @completed_items = @items
    @completed_items.delete_if{ |i| i.completed == false }
  end

  def uncompleted
    @uncompleted_items = @items
    @uncompleted_items.delete_if{ |i| i.completed == true } 
  end
  
  def revert_two(id1, id2)
    @items[id1], @items[id2] = @items[id2], @items[id1]
  end

  def revert_all
    @items.reverse!
  end

  def remove(id)
    @items.delete_at(id)
  end

  def remove_completed
    @items.delete_if {|i| i.completed == true }    
 end

  def toggle_item(id)  
    @items[id].completed = !@items[id].completed 
  end

  def change_to_uncompleted(id)
    @items[id].completed = false
  end

  def change_description(id, description)
    @items[id].desc = description
  end

  def sort
    @items.sort! { |a,b| a.desc <=> b.desc }
  end

  def convert_to_text
    @list = ""
    @items.each do |i|
      if i.completed == true
        @list = @list + "[x] #{i.to_s}\n" 
      else
        @list = @list + "[ ] #{i.to_s}\n"
      end
    end
  @list.chomp!
  end

end

