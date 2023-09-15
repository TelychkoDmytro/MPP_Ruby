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
# prefix_function = ["sin", "cos", "tg", "ctg"]
stack = []
output = []

expression = "( 2 + 5 ) * 5 - 4 - ( 5 ^ 2 + 15 / 5 )"
expression_list = expression.split
expression_list.each do |symbol|
	# if prefix_function.include?(symbol)
	# 	stack.push(symbol)
	# end
	if operations.include?(symbol)
		#prefix_function.include?(stack[-1]) or
		while((priority(symbol) <= priority(stack[-1])))
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

stack.reverse_each do |symbol|
	output.push(symbol)
end

output.each {|symbol| print symbol}