class MyClass
  def self.my_class_method
    puts "This is a class method."
  end
end

obj = MyClass.new

def obj.my_instance_method
  puts "This is an instance method."
end

obj.my_instance_method  # Викликаємо інстанс-метод

MyClass.my_class_method  # Викликаємо класовий метод
