require 'dentaku'
require_relative 'function.rb'
require_relative 'graphics.rb'

class MonteCarloIntegration
  include Function, Graphics
  def initialize(a, b, n, expression)
    @a = a # lower limit of integration
    @b = b # lower limit of integration
    @n = n # number of points to generate
    @expression = expression
  end

  # perform the Monte Carlo classic integration
  def integrate_classic
    sum = 0.0
    @n.times do
      x = rand(@a.to_f..@b.to_f)
      sum += function(x)
    end

    (sum * (@b - @a)) / @n
  end

  # perform the Monte Carlo geometrical integration
  def integrate_geometrically
    max = function_max_min[0]
    min = function_max_min[1]
    if max > 0 && min >= 0
      calculate_area(max)
    elsif max > 0 && min < 0
      (calculate_area(max) + calculate_area(min)).to_f
    else
      calculate_area(min)
    end
  end

  private

  # calculate the area under the curve (geometric method)
  def calculate_area(extremum)
    n = 0
    width = @b - @a
    height = extremum

    @n.times do
      x = rand(@a..@b)
      if extremum >= 0
        y = rand(0.to_f..extremum.to_f)
        n += 1 if y < function(x)
      else
        y = rand(extremum.to_f..0.to_f)
        n += 1 if y > function(x)
      end
    end
    ((n.to_f / @n.to_f) * width * height).to_f
  end
end
