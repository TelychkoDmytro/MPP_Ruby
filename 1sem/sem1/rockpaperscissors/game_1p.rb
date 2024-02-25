values = {
	"rock" => "scissors",
	"scissors" => "paper",
	"paper" => "rock"
}

player = ARGV[0].downcase
computer = values.values[rand(values.size)].downcase

if player == computer
	puts('It\'s a draw')
elsif values[player] == computer
	puts("You won\n")
elsif values[computer] == player
	puts("You lost\n")
else
	puts("#{player}? Really?")
end

