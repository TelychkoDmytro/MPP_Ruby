values = {
	"rock" => "scissors",
	"scissors" => "paper",
	"paper" => "rock"
}

player_1 = ARGV[0].downcase
player_2 = ARGV[1].downcase

if player_1 == player_2
	puts('It\'s a draw')
elsif values[player_1] == player_2
	puts("Player 1 won\n")
elsif values[player_2] == player_1
	puts("Player 2 won\n")
else
	puts("Incorrect values")
end
	
#print(values)

# for arg in ARGV
# 	print(arg)
# end

# print("\n")
# print(ARGV[1])