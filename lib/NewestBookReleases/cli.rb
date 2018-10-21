class NewestBookReleases::CLI
    def call
        puts "Loading. Please wait..."
        NewestBookReleases::Scraper.scrape_genres
        NewestBookReleases::Scraper.scrape_books
        puts "Welcome to Newest Book Releases!"   
        genre_and_book_title
    end 

    def genre_and_book_title
        x = nil 
        while x != "exit"  
            puts "Type the genre you would like to see the newest releases in or type 'list' if you would like to see a list of all the genres available."         
            puts "Type 'exit' if you would like to end the program."
            x = gets.chomp
            if @genre = NewestBookReleases::Genre.all.find {|genre| genre.name == x}
                @genre.books.each.with_index(1) {|book, index| puts "       #{index} - #{book.title}"}
                book_info    
            elsif x == "list"
                puts "Here is a list of all the genres, feel free to copy and paste the genre you'd like to look up!"
                         NewestBookReleases::Genre.all.each do |genre|
                             puts "       #{genre.name}"
                         end 
            elsif x == "exit"
                puts "Thank you. Have a great day!"
            else 
                puts "Invalid Input. Please type the genre that you would like to see the newest releases in."
            end 
        end 
    end 

    def book_info
        y = nil
        while y != "menu"
              puts "Type the number of the title you would like to find out more about or type 'menu' to get back to main menu."
              y = gets.chomp
              if y.to_i > 0 && y.to_i <= @genre.books.size
                 book = @genre.books[y.to_i-1]        
                 puts "       #{book.title} by #{book.author} - #{book.price}"
                 puts " "
              elsif y == "menu"
                puts "You are back in the main menu!"
              else                
                puts "Invalid Input, please try again!"
              end  
        end 
     end 
end 