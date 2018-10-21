class NewestBookReleases::Scraper

    MAIN_URL = "https://www.barnesandnoble.com/h/books/browse"
    GENRE_URL_ARRAY = ["https://www.barnesandnoble.com/b/books/fiction/_/N-1qZ29Z8q8Z10h8?Ns=P_Sales_Rank%7C0", 
    "https://www.barnesandnoble.com/b/books/graphic-novels-comics/_/N-1sZ29Z8q8Zucb?Ns=P_Sales_Rank",
    "https://www.barnesandnoble.com/b/books/graphic-novels-comics/manga/_/N-1sZ29Z8q8Zucc;jsessionid=A736C8C17B4440B80883E18A74F96004.prodny_store01-atgap10?Ns=P_Sales_Rank",
    "https://www.barnesandnoble.com/b/books/mystery-crime/_/N-1sZ29Z8q8Z16g4?Ns=P_Sales_Rank",
    "https://www.barnesandnoble.com/b/books/poetry/_/N-1sZ29Z8q8Z1pqh?Ns=P_Sales_Rank",
    "https://www.barnesandnoble.com/b/books/romance/_/N-1sZ29Z8q8Z17y3?Ns=P_Sales_Rank",
    "https://www.barnesandnoble.com/b/books/science-fiction-fantasy/_/N-1sZ29Z8q8Z180l?Ns=P_Sales_Rank",
    "https://www.barnesandnoble.com/b/books/fiction/thrillers/_/N-1sZ29Z8q8Z1d3u?Ns=P_Sales_Rank"]
    
    def self.scrape_genres
        doc = Nokogiri::HTML(open(MAIN_URL))
        doc.css("section:nth-child(2) li:nth-child(1) ul li").each do |genre|
            name = genre.css("a").text
            url_name = name.gsub("&", "").split(" ").map{|word| word.downcase}.join("-")
            url = GENRE_URL_ARRAY.find {|link| link.include?(url_name)} 
            if name != "Westerns" && name != "Literature"
                NewestBookReleases::Genre.new(name, url)
            end
        end
    end

    def self.scrape_books  
        NewestBookReleases::Genre.all.map do |genre|
            doc = Nokogiri::HTML(open(genre.url))
            doc.css(".product-shelf-grid .product-shelf-info").each do |book|
                    title = book.css(".product-shelf-title a").text.gsub(/\(.*\)/, "").gsub(/\(.*.../, "").strip
                    author = book.css(".product-shelf-author a").text
                    price = book.css(".product-shelf-pricing a").text.gsub("\n", " ").strip.gsub("  ", ", ")
                    genre.add_book(title, author, price)
            end    
        end
    end 
end 