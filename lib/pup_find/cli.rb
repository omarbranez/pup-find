class CLi
    attr_accessor :result_choice, :bio_choice, :resc_choice, :zip_input, :rad_input, :filter_choice
    attr_reader :puppy, :prompt
  
    def initialize
        @prompt = TTY::Prompt.new(quiet: true)
        clear
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
        clear
        @rad_input = @prompt.ask("Please enter the maximum search distance (Min. 1, Max 500).\n") do |rad_valid|
            rad_valid.validate (/^([1-9]|[1-9][0-9]|[1-4][0-9][0-9]|500)$/)
            rad_valid.messages[:valid?] = 'Invalid search distance. Please enter a number between 1 and 500'
        end
    end
        
    def create_menu
        pup_search = PupAPI.get_pup_hash(zip_input, rad_input) 
        Puppy.create_puppies(pup_search)
        result_menu
    end
        
    def result_menu 
        clear
        @result_choice = 
        @prompt.select("Here are up to the first 250 available puppies within #{rad_input} miles of #{zip_input} sorted by distance! \n Select a puppy to read more information about it!", Puppy.all.map{|pup| pup.to_pup_hash}, 
                        'Begin new Zip Code search', 
                        'Filter results by Breed',
                        'Filter results by Size',
                        'Filter results by Rescue Organization',
                        'Exit PupFind',
                        per_page: 10) ## converted the old menu select to a hash with ONLY the attributes i want to show
        result_response
    end
                        
    def result_response
        if @result_choice == 'Begin new Zip Code search'
            Puppy.all.clear # old results were persisting in the menu
            startup
        elsif @result_choice == 'Filter results by Breed'
            filter_prompt
        elsif @result_choice == 'Exit PupFind'
            quit_app
        else 
            (Puppy.all.find {|pup| pup.id == @result_choice}).puppy_bio # menu selection is now based on a unique id number from api
            bio_prompt 
        end
    end
  
    def bio_prompt
        @bio_choice = @prompt.select("Please select from the following options\n", 
        'Get more information about rescue', 
        'Return to previous results', 
        'Exit PupFind')
        case bio_choice 
        when 'Get more information about rescue'
            if @filter_choice
                @result_choice = @filter_choice #if you choose filter first, result_choice doesn't exist and errors out
            end
            (Puppy.all.find {|pup| pup.id == @result_choice}).rescue_bio #the one that matches the unique id
            rescue_prompt
        when 'Return to previous results'
            clear
            result_menu
        when 'Exit PupFind'
            quit_app                
        end
    end

    def rescue_prompt
        @resc_choice = @prompt.select("Please select from the following options\n", 
        'Return to selected puppy', 
        'Return to previous results', 
        'Exit PupFind')
        case resc_choice
        when 'Return to selected puppy'
            clear
            (Puppy.all.find {|pup| pup.id == @result_choice}).puppy_bio
            bio_prompt
        when 'Return to previous results'
            clear
            result_menu
        when 'Exit PupFind'
            quit_app     
        end
    end
    
    def filter_prompt
        @filter_choice = @prompt.select("Please select from the breeds below, sorted alphabetically\n", 
                ((Puppy.all.map {|pup|pup.to_breed_hash}).sort_by {|breed| breed.first}), per_page: 10)
        (Puppy.all.find {|pup| pup.id == @filter_choice}).puppy_bio
        bio_prompt
    end

    def clear
        system "clear"
    end

    def quit_app
        clear
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