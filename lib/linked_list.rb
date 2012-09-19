require 'linked_list_item'

class LinkedList
  attr_reader :first_item

  def initialize *args
    args.each { |payload| self.add_item( payload ) }
  end

  def add_item(payload)
    if @first_item.nil?
      @first_item = LinkedListItem.new(payload)
    else    
      temp_item = @first_item
      temp_item = temp_item.next_list_item until temp_item.next_list_item.nil?
      temp_item.next_list_item = LinkedListItem.new(payload)
    end
  end

  def to_array
    all_items = Array.new
    0.upto( self.size - 1 ) { |num| all_items << self.get(num) }   
    return all_items
  end

  def get_item(n)
    temp = @first_item
    if n >= self.size
      raise IndexError, "Invalid item location"
    else
      n.times { temp = temp.next_list_item }
    end
    return temp 
  end

  def get(n)  # I'd prefer this return the LinkedListItem object, not its payload
    temp = @first_item
    begin
      if n > 0
        n.times { temp = temp.next_list_item }
      else
        @first_item
      end
    rescue NoMethodError
      raise IndexError, "No item in that linked list location"
    end
    temp.nil? ? nil : temp.payload
  end

  def index(term)
    raise IndexError if @first_item.nil?
    i, item = 0, @first_item
    until item.payload == term
      item = item.next_list_item
      i += 1
      break if item.nil?
    end
    item.nil? ? nil : i
  end

  def last
    last_num = self.size
    self.get(last_num-1)
  end

  def size
    n = 0
    item = @first_item
    while item
      n += 1
      item = item.next_list_item
    end
    n
  end

  def to_s
    all_items = self.to_array
    string = "| #{all_items.join(", ")}#{all_items.size > 0 ? ' ' : ''}|"
  end

  # ========= Bonus ========== #

  def [](payload)
    get(payload)
  end

  def []=(n, payload)
    temp = @first_item
    n.times{ temp = temp.next_list_item }
    temp.payload = payload
  end

  def remove(n)
    raise IndexError, 'Cannot remove item at index' if n >=  self.size
    all_items = self.to_array
    all_items.slice!(n)
    @first_item = nil
    all_items.each { |payload| self.add_item(payload) }
  end

end
