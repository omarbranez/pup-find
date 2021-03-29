class CLi
    attr_accessor :result_choice, :bio_choice, :org_choice, :zip_input, :rad_input
    attr_reader :prompt
  
    def initialize
        @prompt = TTY::Prompt.new(quiet: true)
        clear_screen
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
            zip_valid.messages[:valid?] = 'Invalid zip code. Please enter a 5-digit zip code to continue'
        end
        clear_screen
        @rad_input = @prompt.ask("Please enter the maximum search distance, in miles. (Min. 1, Max 500).\n") do |rad_valid|
            rad_valid.validate (/^([1-9]|[1-9][0-9]|[1-4][0-9][0-9]|500)$/)
            rad_valid.messages[:valid?] = 'Invalid search distance. Please enter a number between 1 and 500'
        end
        clear_screen
        puts "Searching, please wait!"
    end
        
    def create_menu
        pup_search = PupAPI.get_pup_hash(zip_input, rad_input) 
        pup_search == nil ? startup : Puppy.create_puppies(pup_search)         
        result_menu
    end
        
    def result_menu 
        clear_screen
        @result_choice = 
        @prompt.select("Here are #{Puppy.all.size} available puppies within #{rad_input} miles of #{zip_input} sorted by distance! \n Select a puppy to read more information about it! \n Scroll to the end to view additional options", Puppy.all.map{|pup| pup.to_pup_hash}, 
                        "Begin new Zip Code search", 
                        'Sort results by Breed',
                        'Sort results by Size',
                        'Exit PupFind',
                        per_page: 10) 
        result_response
    end

    def org_filter_menu
        @result_choice = 
        @prompt.select("Please select from the puppies below, which are from the same rescue as your selection\n", send_pup.same_org.map{|pup| pup.to_pup_hash},
                        'Exit PupFind',
                        per_page: 10)
        result_response
    end
    
    def bio_menu
        @bio_choice = @prompt.select("Please select from the following options\n", 
        'Get more information about rescue',
        'Find more puppies from this rescue', 
        'Return to previous results', 
        'Exit PupFind')
        bio_response
    end

    def org_bio_menu
        @org_choice = @prompt.select("Please select from the following options\n", 
        'Return to selected puppy', 
        'Return to previous results', 
        'Exit PupFind')
        org_response
    end
                        
    def result_response
        case @result_choice 
        when 'Begin new Zip Code search'
            Puppy.all.clear
            clear_screen
            startup
        when 'Sort results by Breed' 
            breed_prompt
        when 'Sort results by Size'
            size_prompt
        when 'Exit PupFind'
            quit_app
        else 
            set_choice
            clear_screen
            send_pup.puppy_bio 
            bio_menu 
        end
    end    
        
    def bio_response
        case @bio_choice 
        when 'Get more information about rescue'
            set_choice
            clear_screen
            Org.all.first.org_bio
            org_bio_menu
        when 'Find more puppies from this rescue'
            set_choice
            clear_screen
            org_filter_menu
        when 'Return to previous results'
            Org.all.clear
            set_choice
            clear_screen
            result_menu
        when 'Exit PupFind'
            quit_app                
        end
    end

    def org_response
        case @org_choice
        when 'Return to selected puppy'
            Org.all.clear
            set_choice
            clear_screen
            send_pup.puppy_bio
            bio_menu
        when 'Return to previous results'
            Org.all.clear
            set_choice
            clear_screen
            result_menu
        when 'Exit PupFind'
            quit_app     
        end
    end
    
    def breed_prompt #can probably combine these three
        @result_choice = @prompt.select("Please select from the breeds below, sorted alphabetically\n", 
            ((Puppy.all.map {|pup| pup.to_breed_hash}).sort_by {|breed| breed.first}), per_page: 10)
        (Puppy.all.find {|pup| pup.id == @result_choice}).puppy_bio
        bio_menu
    end

    def size_prompt
        @result_choice = @prompt.select("Please select from the puppies below, sorted by size\n",
            ((Puppy.all.map {|pup| pup.to_size_hash}).sort_by {|size| size.first}).reverse, per_page: 10)
        (Puppy.all.find {|pup| pup.id == @result_choice}).puppy_bio
        bio_menu
    end

    def send_pup
        Puppy.all.find {|pup| pup.id == @result_choice}
    end

    def clear_screen
        system "clear"
    end

    def quit_app
        clear_screen
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