class CLi

    def test_one
        puts "hello world"
        self.test_two
    end
  
    def test_two
        puts "enter input"
        Scraper.get_pup_hash
        #input = gets.strip.to_i
        #binding.pry
    end

end   