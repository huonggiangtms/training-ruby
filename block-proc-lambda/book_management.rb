module LibraryManagement
  def by_author(author)
    BookCollection.new(@books.filter { |book| book[:author] == author })
  end

  def by_genre(genre)
    BookCollection.new(@books.filter { |book| book[:genre] == genre })
  end

  def before_year(year)
    BookCollection.new(@books.filter { |book| book[:year] < year })
  end

  def after_year(year)
    BookCollection.new(@books.filter { |book| book[:year] > year })
  end

  def price_between(min, max)
    BookCollection.new(@books.filter { |book| book[:price].between?(min, max) })
  end
  
  def available
    BookCollection.new(@books.filter { |book| book[:available] })
  end

  def each(&block)
    @books.each(&block)
  end

  def to_a
    @books
  end
end

class BookCollection
  include LibraryManagement

  def initialize(books)
    @books = books
  end
end

# Khởi tạo danh sách sách
books = BookCollection.new([
  { title: "Ruby Programming", author: "Matz", genre: "Programming", year: 2008, price: 30, available: true },
  { title: "Design Patterns", author: "Gang of Four", genre: "Programming", year: 1994, price: 45, available: false },
  { title: "Clean Code", author: "Robert Martin", genre: "Programming", year: 2008, price: 40, available: true },
  { title: "Harry Potter", author: "J.K. Rowling", genre: "Fantasy", year: 1997, price: 25, available: true }
])

# Sử dụng các scope
programming_books = books.by_genre("Programming")
available_books = books.available
cheap_recent_books = books.after_year(2000).price_between(20, 35).available

puts "Sách lập trình:"
programming_books.each { |book| puts "- #{book[:title]} (#{book[:author]})" }

puts "\nSách có sẵn để mượn:"
available_books.each { |book| puts "- #{book[:title]}" }

puts "\nSách giá từ 20-35, xuất bản sau 2000 và có sẵn:"
cheap_recent_books.each { |book| puts "- #{book[:title]} - $#{book[:price]} (#{book[:year]})" }
