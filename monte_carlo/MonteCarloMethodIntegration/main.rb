require_relative 'monte_carlo_integration'
require_relative 'input'

a = Input.get_numeric_input("Enter the lower limit of integration: ")
b = Input.get_numeric_input("Enter the upper limit of integration: ")

if a >= b
  puts "Error: The lower limit must be less than the upper limit."
  exit
end

n = Input.get_positive_integer_input("Enter the number of random points: ")

print "Enter the expression for the function (e.g., 'pow(x,2)' or '5*x'): "
expression = gets.chomp

monte_carlo_classic = MonteCarloIntegration.new(a, b, n, expression)

if monte_carlo_classic.function_valid? == false
  puts "Error: Invalid expression for the function."
  exit
end

result_classic = monte_carlo_classic.integrate_classic
puts "Estimated integral of the function #{expression} from #{a} to #{b} = #{result_classic.to_f}"

monte_carlo_geom = MonteCarloIntegration.new(a, b, n, expression)

result = monte_carlo_geom.integrate_geometrically
puts "Geometrically estimated integral of the function #{expression} from #{a} to #{b} = #{result}"

monte_carlo_geom.plot_function