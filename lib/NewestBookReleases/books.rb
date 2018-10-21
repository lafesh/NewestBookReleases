class NewestBookReleases::Books 
    attr_accessor :title, :author, :price, :genre
    @@all = []

    def initialize(title, author, price)
        @title = title
        @author = author
        @price = price
        @@all << self
    end 

    def self.all
        @@all
    end    
end 