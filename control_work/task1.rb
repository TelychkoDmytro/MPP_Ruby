class Book
  attr_accessor :title, :author, :year

  def initialize(title, author, year)
    @title = title
    @author = author
    @year = year
  end
end


book1 = Book.new("Пригоди Гаррі Поттера", "Джоан Роулінг", 1997)

# Отримуємо властивості книги
puts "Назва книги: #{book1.title}"
puts "Автор книги: #{book1.author}"
puts "Рік видання: #{book1.year}"

book1.year = 2000

puts "Оновлений рік видання: #{book1.year}"
