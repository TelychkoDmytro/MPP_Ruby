values = {
	"rock" => "scissors",
	"scissors" => "paper",
	"paper" => "rock"
}

if ARGV.size == 0
	puts('What do you want?')
	return
elsif ARGV.size == 1
	player_1 = ARGV[0].downcase
	player_2 = values.values[rand(values.size)]
	# or
	# player_2 = values.to_a.sample[0].downcase
	puts "Player 2 choosed #{player_2}"
elsif ARGV.size == 2
	player_1 = ARGV[0].downcase
	player_2 = ARGV[1].downcase
else
	puts("There are too more arguments")
	return
end

if player_1 == player_2
	puts('It\'s a draw')
elsif values[player_1] == player_2
	puts("You won\n")
elsif values[player_2] == player_1
	puts("You loose\n")
else
	puts("#{player_1} and #{player_2}? Really?")
end