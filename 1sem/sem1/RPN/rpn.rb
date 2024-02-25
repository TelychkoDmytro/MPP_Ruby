# Remark: type sin(x) with brakets
def priority(operand)
	if operand == "^"
		return 3
    elsif operand == "*" or operand == "/"
		return 2
    elsif operand == "+" or operand == "-"
		return 1
    else
    	return 0
    end
end
operations = ["+", "-", "*", "/", "^"]
prefix_function = ["sin", "cos", "tg", "ctg"]
stack = []
output = []

# expression = "( 2 + 5 ) * 5 - 4 * cos(30) - ( 5 ^ 2 + 15 / 5 ) + sin(60)"
expression = ARGV[0]
expression_list = expression.split
puts expression_list.class
expression_list.each do |symbol|
	if prefix_function.include?(symbol)
		stack.push(symbol)
	elsif operations.include?(symbol)
		#prefix_function.include?(stack[-1]) or
		while(prefix_function.include?(stack[-1]) or (priority(symbol) <= priority(stack[-1])))
			output.push(stack.pop)
		end
		stack.push(symbol)
	elsif symbol == ")"
		while(stack[-1] != "(")
			output.push(stack.pop)
		end
		stack.pop
	elsif symbol == "("
		stack.push(symbol)
	else # digits
		output.push(symbol)
	end
end

stack.reverse_each {|symbol| output.push(symbol)}

output.each {|symbol| print "#{symbol} "}