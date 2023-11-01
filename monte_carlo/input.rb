module Input
  def self.get_numeric_input(prompt)
    print prompt
    input = gets.chomp
    begin
      Float(input)
    rescue
      puts "Error: Invalid input. Please enter a valid number."
      exit
    end
  end

  def self.get_positive_integer_input(prompt)
    print prompt
    input = gets.chomp
    begin
      num = Integer(input)
      if num <= 0
        raise StandardError, "Input must be a positive integer."
      end
      num
    rescue
      puts "Error: Invalid input. Please enter a positive integer."
      exit
    end
  end
end