# Абстрактний клас стану
class State
  attr_accessor :context

  def press_power_button
    raise NotImplementedError, "#{self.class} має реалізувати метод 'press_power_button'"
  end

  def use_phone
    raise NotImplementedError, "#{self.class} має реалізувати метод 'use_phone'"
  end
end

# Конкретний стан "Телефон вимкнений"
class OffState < State
  def press_power_button
    puts "Увімкнення телефону..."
    # Змінюємо стан на "Телефон увімкнений"
    @context.transition_to(OnState.new)
  end

  def use_phone
    puts "Телефон вимкнений, неможливо використовувати."
  end
end

# Конкретний стан "Телефон увімкнений"
class OnState < State
  def press_power_button
    puts "Вимкнення телефону..."
    # Змінюємо стан на "Телефон вимкнений"
    @context.transition_to(OffState.new)
  end

  def use_phone
    puts "Використання телефону для дзвінків, повідомлень і т. д."
  end
end

# Контекст - телефон
class Phone
  attr_accessor :state

  def initialize
    # Початковий стан - "Телефон вимкнений"
    @state = OffState.new
    @state.context = self
  end

  def transition_to(state)
    puts "Зміна стану на #{state.class}"
    @state = state
    @state.context = self
  end

  def press_power_button
    @state.press_power_button
  end

  def use_phone
    @state.use_phone
  end
end

# Клієнтський код
phone = Phone.new

# Увімкнути телефон
phone.press_power_button

# Використання телефону
phone.use_phone

# Вимкнути телефон
phone.press_power_button
