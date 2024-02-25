# state
class FoodOrderState
  attr_accessor :context

  def next
    raise NotImplementedError, 'Subclasses must implement this method'
  end
end

class OrderInitiatedState < FoodOrderState
  def next
    puts 'Order initiated'
    @context.transition_to(OrderPlacedState.new)
  end
end

class OrderPlacedState < FoodOrderState
  def next
    puts 'Order placed'
    @context.transition_to(FoodPreparationState.new)
  end
end

class FoodPreparationState < FoodOrderState
  def next
    puts 'Start cooking'
    @context.transition_to(WaitingToBePickedState.new)
  end
end

class WaitingToBePickedState < FoodOrderState
  def next
    puts 'Cooked, waiting to be picked'
    @context.transition_to(OutForDeliveryState.new)
  end
end

class OutForDeliveryState < FoodOrderState
  def next
    puts 'Picked, waiting to be delivered'
    @context.transition_to(DeliveredState.new)
  end
end

class DeliveredState < FoodOrderState
  def next
    puts 'Delivered to customer'
    # No need to transition to another state because it's the final state
  end
end

# Context - Food Order
class FoodOrder
  attr_accessor :FoodOrderState

  def initialize
    @FoodOrderState = OrderInitiatedState.new
    @FoodOrderState.context = self
  end

  def transition_to(state)
    @FoodOrderState = state
    @FoodOrderState.context = self
  end

  def next
    @FoodOrderState.next
  end
end

# Example usage:
order = FoodOrder.new
order.next
order.next
order.next
order.next
order.next
order.next
