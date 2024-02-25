
def estimate_pi(iterations)
	in_circle = 0
	total_points = 0

	iterations.times do
		x = rand(-1.0..1.0)
		y = rand(-1.0..1.0)

		distance = Math.sqrt(x**2 + y**2)

		# Якщо менше 1, то точка знаходить в середені
		# кола, оскільки його радіус R = 1
		if distance <= 1
			in_circle += 1
		end

		total_points += 1
	end

	4.0 * in_circle / total_points
end

estimated_pi = estimate_pi(1_000)
difference = (estimated_pi - Math::PI).abs

puts estimated_pi
puts difference
