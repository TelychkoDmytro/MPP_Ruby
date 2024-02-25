class Player
	attr_accessor :health, :money

	def initialize(health, money)
		@health = health
		@money = money
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

	def initialize(player_health, player_money)
		@scenes = {}
		@current_scene = nil
		@player = Player.new(player_health, player_money)
	end

	def game(&block)
		instance_eval(&block)
		start
	end

	def scene(name, &block)
		@current_scene = name
		@scenes[@current_scene] = { message: '', options: [] }
		instance_eval(&block)
	end

	def option(text, options = {})
		@scenes[@current_scene][:options] << { text: text, options: options }
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

	def option(text, next_scene, options = {})
	  @scenes[@current_scene][:options] << { text: text, next_scene: next_scene, options: options }
	end

	

	def start
		@current_scene = @scenes.keys.first
		play_scene
	end

	def print_scene_info(scene)
	  puts "Майстер: #{scene[:message]}"
	  puts "Здоров'я гравця: #{@player.health}"
	  puts "Гроші гравця: #{@player.money}"
	  puts "Виберіть дію:"
	end

	def print_options(scene)
	  scene[:options].each_with_index do |option, index|
	    puts "#{index + 1}. #{option[:text]}"
	  end
	end

	def handle_choice(choice, scene)
	  if choice > 0 && choice <= scene[:options].length
	    selected_option = scene[:options][choice - 1]
	    handle_option(selected_option)
	  else
	    puts "Майстер: Введіть правильний варіант."
	  end
	end

	def end_game?
		if @current_scene == :end_game
      end_game
      return true
    end
    return false
  end

	private

	def play_scene
		while @current_scene && @player.alive?
			if end_game?
				break
			end

			scene = @scenes[@current_scene]
			
			if scene
				print_scene_info(scene)
				print_options(scene)

				choice = gets.to_i
				handle_choice(choice, scene)
			else
				puts "Майстер: Сцена #{@current_scene} не існує."
			end
			
		end
	end


	def handle_option(option)
		if option[:options] && option[:options][:difficulty]
			difficulty = option[:options][:difficulty]
			roll = roll_d20
			puts "Майстер: Гравець кидає кубик d20 та вибиває #{roll}."
			
			if roll >= difficulty
				puts "Майстер: Успіх! #{option[:text]}"
				@current_scene = option[:next_scene]
			else
				puts "Майстер: Невдача! Ви втрачаєте здоров'я."
				@player.decrease_health(2) # Наприклад, втрата 2 одиниць здоров'я при невдачі
			end
		elsif option[:options] && option[:options][:currency_reward]
			reward = option[:options][:currency_reward]
			puts "Майстер: Гравець отримав додаткову винагороду в розмірі #{reward} за виконання завдання."
			@player.money += reward
			@current_scene = option[:next_scene]
		else
			@current_scene = option[:next_scene]
		end
	end


	def roll_d20
		rand(1..20)
	end

	def end_game
		if @player.alive?
			puts "Гравець втік, але втратив кров. Здоров'я: #{@player.health}"
		else
			puts "Гравець втратив усе здоров'я і помер. Гра закінчена."
		end
		 @current_scene = nil
	end
end

# Приклад використання:

player_health = 10
player_money = 5
dnd = DnDScenario.new(player_health, player_money)

dnd.game do
	scene :start do
		message "Ви стоїте перед темним входом у печеру."
		option "Увійти у печеру", :dark_cave, currency_reward: 10
		option "Повернутися", :end_game
	end

	scene :dark_cave do
		message "Печера темна і холодна. Ви чуєте дивні звуки."
		option "Досліджувати далі", :treasure_room, difficulty: 12
		option "Вернутися на вихід", :start
	end

	scene :treasure_room do
		message "Ви знаходите скарби у середині печери!"
		option "Вернутися на вихід", :end_game
	end
end