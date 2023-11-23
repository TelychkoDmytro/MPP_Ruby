module Printable
  def print_info
    puts "Information about the current object:"
    self.instance_variables.each do |var|
      value = self.instance_variable_get(var)
      puts "#{var}: #{value}"
    end
  end
end

# Приклад використання модуля Printable з класом SampleClass
class SampleClass
  include Printable

  def initialize(name, age)
    @name = name
    @age = age
  end
end

# Створюємо об'єкт класу SampleClass
sample_object = SampleClass.new("John", 25)

# Викликаємо метод print_info, який доданий завдяки модулю Printable
sample_object.print_info

=begin
  
Output:

PS C:\Users\login\Ruby\control_work_2> ruby printable.rb
Information about the current object:
@name: John
@age: 25
  
=end