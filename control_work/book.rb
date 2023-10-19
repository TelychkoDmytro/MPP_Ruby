class Book
  attr_accessor :title, :author, :year
  # after this we don't need get() and set(methods)

  def initialize(title, author, year)
    @title = title
    @author = author
    @year = year
  end

end


book1 = Book.new("Garry Potter", "Джоан Роулінг", 1997)

# Отримуємо властивості книги
puts "Назва книги: #{book1.title}"
puts "Автор книги: #{book1.author}"
puts "Рік видання: #{book1.year}"

book1.year = 1998

puts "Оновлений рік видання: #{book1.year}"
