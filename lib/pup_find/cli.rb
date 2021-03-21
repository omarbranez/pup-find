class CLi

    attr_reader :puppy, :user_zip
    
    def run
        on_open 
    end
 
    def on_open 
        puts banner 
        get_data 
    end 
 
    def get_data 
        puts "Please enter your 5-digit zip code." 
        z_input = gets.strip 
        if z_input.match?(/[0-9]{5}/) ? zip_input = z_input : get_data 
        end 
        pup_search = Scraper.get_pup_hash(zip_input) #separate processes? 
        Scraper.get_color_hash 
        Puppy.create_puppies(pup_search) 
        color_pups 
        result_menu 
    end 
 
    def color_pups 
        Puppy.all.each do |puppy| 
            colors = Scraper.get_color_hash 
            puppy.add_pup_colors(colors) 
        end
    end   
    
    # def get_radius_input ## save for reinstating radius search
    #     puts "Please enter how far you would like to search, in miles. The maximum number is 500." #need to check validity, and separate
    #     r_input = gets.strip
    #     if ("1".."500").cover?(r_input) ? zip_radius = r_input : get_radius_input
    #     end
    # end
 
    # save for later for refactoring?
    # def valid_zip_input?(input)
    #     input.match?(/[0-9]{5}/)
    # end
 
    def banner 
        puts "* * * * * * * * * * * * * * * * * * *" 
        puts "*                                   *" 
        puts "*       Welcome to PupFind!         *" 
        puts "*     Your new friend awaits!       *" 
        puts "*                                   *" 
        puts "* * * * * * * * * * * * * * * * * * *" 
    end 
 
    def result_menu 
        puts "Here are the first 50 available puppies within 500 miles of your zip code, sorted by distance!" #zip_input didn't travel all the way through
        Puppy.all.each.with_index do |puppy, index| 
            #@prompt.select = "Here are the available puppies within 500 miles of #{zipcode}, sorted by distance!" %w("#{puppy.name} || #{puppy.breed} || #{puppy.sex} || #{puppy.age} old ||")
            puts "#{index+1}. || #{puppy.name} || #{puppy.breed} || #{puppy.sex} || #{puppy.age} old ||"
            puts "-------------------------------------------------------------------------------------------------------"
        end
        result_prompt
    end
 
    def result_prompt 
        puts "To get more information about a puppy, enter its number" 
        puts "To refine results, select from criteria: 'breeds' 'age' 'gender'" # need to implement sort 
        puts "To begin a new query, enter 'restart'" 
        puts "To quit, enter 'quit'" 
        input = gets.strip + "." #messes with restart and quit, will implement tty prompt to correct 
        if input == "restart" 
            on_open 
        elsif input == "quit" 
            quit_app 
        elsif !/\A\d+\z/.match(input) 
            Puppy.all[(input.to_i)-1].puppy_bio 
        #elsif input == "breeds" 
            # puts Puppy.all.breed 
        #elsif input == "age" 
            # puts Puppy.all.age 
        #elsif input == "sex" 
            # puts Puppy.all.sex 
        else 
            result_prompt 
        end 
        bio_prompt
    end 
 
    def bio_prompt 
        input = gets.strip 
        if input == "results" 
            self.result_menu 
        elsif input == "quit" 
            quit_app 
        else 
            bio_prompt 
        end 
    end 
 
    def quit_app 
        puts "Thank you for using PupFind!" 
    end

 end 
 
    # hello pseudocode! this will be deleted as functionality is added 
 # #       .-.                     .-. 
 # #      (   `-._______________.-'   )
 # #       \                         / 
 # #        >= Welcome to PupFind! =< 
 # #       /      ______________     \ 
 # #  jgs (   ,-'`              `'-,  ) 
 # #       `-'                      `-'
 
 