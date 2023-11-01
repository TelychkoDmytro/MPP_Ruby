class Array
	def shuffle
		self.sort_by {rand}
	end

	def choice
		self.shuffle.first
	end
end

class MontyHall
	def initialize
		@doors = ['car', 'goat', 'goat']
	end

	def pick_door
		return rand(3)
	end

	def reveal_door(pick)
		available_doors = [0, 1, 2]
		available_doors.delete(pick)
		available_doors.delete(@doors.index('car'))
		return available_doors.choice
	end

	def staying_wins?(pick)
		won?(pick)
	end

	def switching_wins?(pick, open_door)
		switched_pick = ([0, 1, 2] - [open_door, pick]).first
		won?(switched_pick)
	end

	def won?(pick)
		@doors[pick] == 'car'
	end
end

if __FILE__ == $0
	ITERATIONS = (ARGV.shift || 1_000_000).to_i
	staying = 0
	switching = 0

	ITERATIONS.times do
		mh = MontyHall.new
		picked = mh.pick_door
		revealed = mh.reveal_door(picked)
		staying += 1 if mh.staying_wins?(picked)
		switching += 1 if mh.switching_wins?(picked, revealed)
	end

	staying_rate = (staying.to_f / ITERATIONS) * 100
	switching_rate = (switching.to_f / ITERATIONS) * 100

	puts "Staying: #{staying_rate}%."
	puts "Switching: #{switching_rate}%"

end
 