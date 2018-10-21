class NewestBookReleases::Genre
    attr_accessor :name, :url
    @@all = []
    
    def initialize(name, url)
        @name = name
        @url = url 
        @@all << self
        @books = []
    end 
 
    def self.all
        @@all
    end 

    def add_book(title, author, price)
        book = NewestBookReleases::Books.new(title, author, price)
        @books << book 
        book.genre = self 
    end 

    def books
        @books
    end  
end 