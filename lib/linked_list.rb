require 'linked_list_item'

class LinkedList
  attr_reader :first_item

  def initialize *args
    args.each { |payload| self.add_item( payload ) }
  end

  def add_item(payload)
    new_item =  LinkedListItem.new(payload)
    if @first_item.nil?
      @first_item = new_item
    else    
      temp_item = @first_item
      temp_item = temp_item.next_list_item until temp_item.next_list_item == nil
      temp_item.next_list_item = new_item
    end
  end

  def get(n)  # I'd prefer this return the LinkedListItem object, not its payload
    temp =  @first_item
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

  def last
    last_num = self.size
    self.get(last_num-1)
  end

  def size
    count = 1
    if @first_item.nil?
      return 0
    else
      last_item = @first_item
      until last_item.next_list_item.nil?
        last_item = last_item.next_list_item
        count +=1
      end
    end
  count
  end

  def to_s
    all_items = []
    0.upto( self.size - 1 ) { |num| all_items << self.get(num) }
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
    raise IndexError, 'Cannot remove item at index' if n > self.size - 1
    all_items = []
    0.upto( self.size - 1 ) { |num| all_items << self.get(num) }  
    all_items.slice!(n)
    @first_item = nil
    all_items.each { |payload| self.add_item(payload) }
  end

end
