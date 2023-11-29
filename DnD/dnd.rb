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

  def message(text)
    @scenes[@current_scene][:message] = text
  end

  def option(text, next_scenes, options = {})
    @scenes[@current_scene][:options] << { text: text, next_scenes: next_scenes, options: options }
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
    if option[:options]
      handle_option_with_options(option)
    else
      handle_option_without_options(option)
    end
  end

  def handle_option_with_options(option)
    if option[:options][:difficulty]
      handle_option_with_difficulty(option)
    end
    if option[:options][:currency_reward]
      handle_option_with_currency_reward(option)
    end
    
    handle_default_option(option)
    
  end

  def handle_option_without_options(option)
    handle_default_option(option)
  end

  def handle_option_with_difficulty(option)
    difficulty = option[:options][:difficulty]
      roll = roll_d20
      puts "Майстер: Гравець кидає кубик d20 та вибиває #{roll}."
      
      if roll >= difficulty
        puts "Майстер: Успіх! #{option[:text]}"
        @current_scene = option[:next_scenes].first
      else
        puts "Майстер: Невдача! Ви втрачаєте здоров'я."
        @current_scene = option[:next_scenes].last
      end
    end

  def handle_option_with_currency_reward(option)
    reward = option[:options][:currency_reward]
    puts "Майстер: Гравець отримав додаткову винагороду в розмірі #{reward} за виконання завдання."
    @player.money += reward
    @current_scene = option[:next_scenes].first
  end

  def handle_default_option(option)
    @current_scene = option[:next_scenes].first
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
  scene :tavern do
    message "Ви стоїте перед Ваші ноги ступають на територію віддаленого містечка Ельрендор, розташованого в серці великого і загадкового королівства Мідгард. Сонце мерехтить на небосхилі, а тіні ковзають між старовинними будівлями, які виходять за межі горизонту. Спереду вас вибухає веселий гамір ринку, де торговці, пригодники та різні істоти зібралися, щоб обмінюватися та ділитися своїми історіями.

Ви знаходите своїх героїв в невеликому таверні \"Драконів крила\", де дзвін металевого кухольця зустрічає вас при вході. Тут, за столиком, сидить таємничий літній мудрець, який готовий запропонувати вам пригоди, в які ви, можливо, навіть не уявляли. Сприйміть виклик та готуйтеся до захоплюючих випробувань, де ваші рішення формуватимуть історію цього світу. І так, приготуйтесь до того, що вас чекає відомий або невідомий шлях у цьому фантастичному пригодницькому світі! входом у печеру."
    option "Звернутися до таємничого літнього мудреця", [:sage]
    option "Дослідження ринку", [:market]
  end

  scene :sage do 
    message "Ви вирішуєте звернутися до таємничого літнього мудреця, сидячи за столиком у таверні \"Драконів крила\". Його довга сива борода сповивається навколо його старовинного крісла, а очі світяться вогнями великого знання. Він піднімає свій чарівний посох та вас визиває словами, звучать вам на диво природним чином:

\"Ласкаво просимо, подорожники. Я — Гвідіон Стародавній, Чарівник Мудрості. Я чую, що ви шукаєте захоплюючих пригод та таємниць, які таїть наш світ. Чи готові ви віддати свої серця в руки долі?\"

Гвідіон дивиться на вас, очій в очі, очікуючи вашої відповіді. Що ви вирішуєте сказати?"
    option "Погодитися на пригоди", [:end_game]
    option "Промовчати", [:end_game]
  end

  scene :market do 
    option "end", [:end_game]
  end
end