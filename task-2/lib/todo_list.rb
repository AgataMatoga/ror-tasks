class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items[:db] == nil
      raise IllegalArgument
    end
    @db = items[:db]
    @network = items[:social_network] 
  end

  def empty?
    @db.items_count == 0
  end

  def size
    @db.items_count
  end
  
  def <<(new_item)
    if new_item == nil || new_item[:title] == "" || new_item[:title].length < 4
	nil
    else
      new_item.title = new_item.title[0 .. 15] if new_item.title.length >= 255
      
      @db.add_todo_item(new_item)
      @network.notify(new_item) if @network
    end
  end

  def first
   if @db.items_count == 0 
     nil
   else
      @db.get_todo_item(0)
   end
  end
 
  def toggle_state(item)

    if @db.get_todo_item(item)  
 
      if @db.todo_item_completed?(item) == true
        @db.complete_todo_item(item, false)
      else
        @db.complete_todo_item(item, true)
        item = @db.get_todo_item(item)
	item.title = item.title[0 .. 255] if item.title.length >= 255
        @network.notify(item) if @network
      end
     
     else
        raise IllegalArgument
    end
  end

  def last
    if @db.items_count == 0
      nil
    else
      @db.get_todo_item(@db.items_count - 1)
    end
  end
  

end
