#Добре, мені подобається. Давай додамо новий функціонал. Наприклад, на зараз можна додати клас Player або щось таке, у якого є здоров'я. І при виборі "Відмовити і втекти" не завершувати гру, а віднімати якусь кількість здоров'я.
# Це мабуть можна прописувати у коді, там де ми вже використовуємо DSL. І додати перевірку на здоров'я. Тоді, гра завершується лише тоді, коли здоров'я падає до 0 або нижче нуля. Цю перевірку можна додати в самому коді використання DSL, або ж додати кудись, що перевіряє здоров'я, і завершує гру, або пише про втрачене зродов'я і що зараз відбуваєтсья і варіанти, що можна зробити.



class DnDScenario
  attr_accessor :current_scene

  def initialize
    @scenes = {}
    @current_scene = nil
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

  def start
    @current_scene = @scenes.keys.first
    play_scene
  end

   private

  def play_scene
    while @current_scene
      scene = @scenes[@current_scene]
      puts "Майстер: #{scene[:message]}"
      puts "Виберіть дію:"
      scene[:options].each_with_index do |option, index|
        puts "#{index + 1}. #{option[:text]}"
      end

      choice = gets.to_i
      if choice > 0 && choice <= scene[:options].length
        @current_scene = scene[:options][choice - 1][:next_scene]
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
    puts "Гравець завершив гру."
    # Якщо вам потрібно виконати які-небудь завершальні дії, ви можете додати їх тут.
  end
end

# Приклад використання:

dnd = DnDScenario.new

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
  option "Взяти скарби і втекти", :end_game
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
