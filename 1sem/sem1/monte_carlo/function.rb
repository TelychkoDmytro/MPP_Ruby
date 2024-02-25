require 'dentaku'

module Function
  # calculate the function value at a given x
  def function(x)
    calculator.evaluate(@expression, x: x).to_f
  end

  # check if the function is valid within the integration range
  def function_valid?(a: @a, b: @b)
    step = 0.1
    a.step(b, step) {
      |x| return false if function(x) == nil
    }
    true
  end

  # find the maximum and minimum values of the function
  def function_max_min(a: @a, b: @b)
    step = 0.1
    max = -Float::INFINITY
    min = Float::INFINITY

    a.step(b, step) do |x|
      y = function(x)
      max = y if y > max
      min = y if y < min
    end

    [max, min]
  end

  def calculator
    calculator = Dentaku::Calculator.new
    # add a power function
    calculator.add_function(:pow, :numeric, ->(mantissa, exponent) { mantissa ** exponent })
    calculator
  end
end
