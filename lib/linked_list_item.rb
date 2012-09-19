class LinkedListItem
  attr_reader :next_list_item
  attr_reader :payload

  def initialize( payload )
    @payload = payload
  end

  def next_list_item= (linked_list_item)
  raise ArgumentError, "Cannot link ListItem to self" if linked_list_item == self
  @next_list_item = linked_list_item
  end

  def payload=(arg)
    @payload = arg
  end

  def last?
    @next_list_item == nil
  end
end


