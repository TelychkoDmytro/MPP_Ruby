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
operands = ["+", "-", "*", "/", "^"]
# prefix_function = ["sin", "cos", "tg", "ctg"]
stack = []
output = []

expression = "(2+5)*5/4-(5+15/5)"

expression.each_char do |symbol|
	# if prefix_function.include?(symbol)
	# 	stack.push(symbol)
	if symbol == ")"
		while(stack[-1] != "(")
			output.push(stack.pop)
		end
		stack.pop
	elsif operands.include?(symbol)
		#prefix_function.include?(stack[-1]) or 
		# doesn't work, don't what what is лівоасоціативна
		while((priority(symbol) < priority(stack[-1])))
			output.push(stack.pop)
		end
		stack.push(symbol)
	elsif symbol == "("
		stack.push(symbol)
	else
		output.push(symbol)
	end
end

stack.reverse_each do |symbol|
	output.push(symbol)
end



puts output