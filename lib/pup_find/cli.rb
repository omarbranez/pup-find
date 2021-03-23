class CLi
    attr_accessor :result_choice, :bio_choice, :res_choice, :zip_input
    attr_reader :puppy, :user_zip, :prompt
  
    def initialize
        @prompt = TTY::Prompt.new
        banner
        puts "Welcome to PupFind!"
        startup
    end

    def startup    
        get_data
        create_menu
    end
   
    def get_data
        @zip_input = @prompt.ask("Please enter your 5-digit zip code.\n") do |zip_valid|
            zip_valid.validate(/[0-9]{5}/)
            zip_valid.messages[:valid?] = 'Invalid zip code. Please enter a valid zip code to continue'
        end
    end
        
    def create_menu
        pup_search = PupAPI.get_pup_hash(zip_input) #separate processes?
        Puppy.create_puppies(pup_search)
        result_menu
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
   
        
    def result_menu 
        @result_choice = 
        @prompt.select("Here are the available puppies within 500 miles of your zip code sorted by distance! \n Select a puppy to read more information about it!", Puppy.all.map{|pup| pup.to_pup_hash}, 
                        'Enter new Zip Code', 
                        'Exit PupFind') ## converted the old menu select to a hash with ONLY the attributes i want to show
        result_response
    end
                        
    def result_response
        if @result_choice == 'Enter new Zip Code'
            Puppy.all.clear
            startup
        elsif @result_choice == 'Exit PupFind'
            quit_app
        else 
            (Puppy.all.find {|pup| pup.id == @result_choice}).puppy_bio # menu selection is now based on an id number from api
            bio_prompt 
        end
    end
  
    def bio_prompt
        bio_choice = @prompt.select("Please select from the following options\n", 'Get more information about rescue', 'Return to previous results', 'Exit PupFind')
        case bio_choice 
        when 'Get more information about rescue'
            (Puppy.all.find {|pup| pup.id == @result_choice}).rescue_bio
            rescue_prompt
        when 'Return to previous results'
            result_menu
        when 'Exit PupFind'
            quit_app                
        end
    end

    def rescue_prompt
        res_choice = @prompt.select("Please select from the following options\n", 'Return to selected puppy', 'Return to previous results', 'Exit PupFind')
        case res_choice
        when 'Return to selected puppy'
            (Puppy.all.find {|pup| pup.id == @result_choice}).puppy_bio
            bio_prompt
        when 'Return to previous results'
            result_menu
        when 'Exit PupFind'
            quit_app     
        end
    end
        
    def quit_app
        puts "Thank you for using PupFind!"   
    end
    
    def banner
        puts "███████████                       ███████████  ███                  █████"
        puts "░███░░░░░███                      ░███░░░░░░█  ░░                  ░░███ "
        puts "░███    ░███ █████ ████ ████████  ░███   █ ░  ████  ████████     ███████ "
        puts "░██████████ ░░███ ░███ ░░███░░███ ░███████   ░░███ ░░███░░███   ███░░███ "
        puts "░███░░░░░░   ░███ ░███  ░███ ░███ ░███░░░█    ░███  ░███ ░███  ░███ ░███ "
        puts "░███         ░███ ░███  ░███ ░███ ░███  ░     ░███  ░███ ░███  ░███ ░███ "
        puts "█████        ░░████████ ░███████  █████       █████ ████ █████░░████████"
        puts "░░░░░          ░░░░░░░░  ░███░░░  ░░░░░       ░░░░░ ░░░░ ░░░░░  ░░░░░░░░ "
        puts "                         ░███ "
        puts "                         █████ "
        puts "                         ░░░░░ "
    end     

end