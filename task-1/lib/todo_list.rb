class TodoList
  attr_accessor :items

  class Item
    attr_accessor :desc, :complete
  
    def initialize(item)
      @desc = item
      @complete = false
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
    @items[id].complete
  end
  
  def complete(id)
    @items[id].complete = true
  end

end
