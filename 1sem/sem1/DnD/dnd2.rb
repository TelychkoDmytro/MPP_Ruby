class GameMaster
  def initialize(&block)
    @scenes = {}
    instance_eval(&block) if block_given?
  end

  def scene(name, &block)
    @scenes[name] = Scene.new(&block)
  end

  def play
    current_scene = @scenes.values.first
    until current_scene.nil?
      current_scene.display_message
      choice = current_scene.get_player_choice
      current_scene = @scenes[choice]
    end
  end
end

class Scene
  def initialize(&block)
    @message = ""
    @options = {}
    instance_eval(&block) if block_given?
  end

  def display_message
    puts @message
    @options.each { |key, option| puts "#{key}. #{option[:text]}" }
  end

  def get_player_choice
    print "Your choice: "
    gets.chomp.to_sym
  end

  def option(key, text, next_scene)
    @options[key] = { text: text, next_scene: next_scene }
  end

  def method_missing(method, *args, &block)
    @options[method]
  end
end

# Простий приклад використання DSL

GameMaster.new do
  scene :start do
    message "You find yourself in a dark cave. A passage leads left and another leads right."
    option :left, "Go left into the darkness", :dark_tunnel
    option :right, "Go right towards a faint light", :exit
  end

  scene :dark_tunnel do
    message "You venture into the dark tunnel. Suddenly, you hear growling ahead."
    option :attack, "Attack the source of the growling", :battle
    option :retreat, "Retreat back to the cave entrance", :start
  end

  scene :exit do
    message "Congratulations! You've found the exit and emerged into the sunlight."
    option :end, "End the game", nil
  end

  scene :battle do
    message "A fierce battle ensues with a pack of wolves. You must fight to survive!"
    option :fight, "Fight valiantly", :victory
    option :flee, "Attempt to flee", :defeat
  end

  scene :victory do
    message "Victory is yours! You emerge victorious from the battle."
    option :end, "End the game", nil
  end

  scene :defeat do
    message "Unfortunately, the wolves overwhelm you. Your journey ends here."
    option :end, "End the game", nil
  end
end.play
