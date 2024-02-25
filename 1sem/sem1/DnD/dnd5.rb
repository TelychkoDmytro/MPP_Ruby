class Player
	attr_accessor :health

	def initialize(health)
		@health = health
	end

	def decrease_health(amount)
		@health -= amount
	end

	def alive?
		@health > 0
	end
end

class DnDScenario
	attr_accessor :current_scene

	def initialize(player_health)
		@scenes = {}
		@current_scene = nil
		@player = Player.new(player_health)
	end

	def scene(name, &block)
		@current_scene = name
		@scenes[@current_scene] = { message: '', options: [] }
		instance_eval(&block)
	end

	def message(text)
		@scenes[@current_scene][:message] = text
	end

	def option(text, next_scene)
		@scenes[@current_scene][:options] << { text: text, next_scene: next_scene }
	end

	 def option(text, next_scene, damage = 0)
		@scenes[@current_scene][:options] << { text: text, next_scene: next_scene, damage: damage }
	end

	def start
		@current_scene = @scenes.keys.first
		play_scene
	end

	 private

	def play_scene
		while @current_scene && @player.alive?
			scene = @scenes[@current_scene]
			puts "Майстер: #{scene[:message]}"
			puts "Здоров'я гравця: #{@player.health}"
			puts "Виберіть дію:"
			scene[:options].each_with_index do |option, index|
				puts "#{index + 1}. #{option[:text]}"
			end

			choice = gets.to_i
			if choice > 0 && choice <= scene[:options].length
				option = scene[:options][choice - 1]
				@player.decrease_health(option[:damage]) if option[:damage] > 0
				@current_scene = option[:next_scene]
			else
				puts "Майстер: Введіть правильний варіант."
			end

			if @current_scene == :end_game
				end_game
				break
			end
		end
	end

	def end_game
		if @player.alive?
			puts "Гравець втік, але втратив кров. Здоров'я: #{@player.health}"
		else
			puts "Гравець втратив усе здоров'я і помер. Гра закінчена."
		end
	end
end

# Приклад використання:

player_health = 10
dnd = DnDScenario.new(player_health)

dnd.scene(:start) do
	message "Ви стоїте перед темним входом у печеру."
	option "Увійти у печеру", :dark_cave
	option "Повернутися", :end_game
end

dnd.scene(:dark_cave) do
	message "Печера темна і холодна. Ви чуєте дивні звуки."
	option "Досліджувати далі", :treasure_room
	option "Вернутися на вихід", :start
end

dnd.scene(:treasure_room) do
	message "Ви знаходите скарби та величезного дракона."
	option "Поговорити з драконом", :dragon_talk
	option "Взяти скарби і втекти", :end_game, 5
end


dnd.scene(:dragon_talk) do
	message "Дракон розповідає вам історію свого життя та просить про допомогу."
	option "Допомогти дракону", :good_ending
	option "Відмовити і втекти", :bad_ending
end

dnd.scene(:good_ending) do
	message "Ви допомогли дракону і отримали його вдячність. Ви виграли!"
	option "Грати знову", :start
	option "Закінчити гру", :end_game
end

dnd.scene(:bad_ending) do
	message "Дракон розлючений і атакує вас. Гра закінчена."
	option "Грати знову", :start
	option "Закінчити гру", :end_game
end

dnd.start