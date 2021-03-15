class CLi

    attr_accessor :zip_input, :zip_radius

    def on_open
        puts banner
        self.get_zip_input
        self.get_radius_input
        #binding.pry
        Scraper.get_pup_hash(@zip_input, @zip_radius)
    end
    
    def get_zip_input
        puts "Please enter your 5-digit zip code." 
        z_input = gets.strip
        if z_input.match?(/[0-9]{5}/) ? @zip_input = z_input : get_zip_input
        end
    end
    
    def get_radius_input
        puts "Please enter how far you would like to search, in miles. The maximum number is 500." #need to check validity, and separate
        r_input = gets.strip
        if ("1".."500").cover?(r_input) ? @zip_radius = r_input : get_radius_input
        end
    end
    
    # save for later for refactoring?
    # def valid_zip_input?(input)
    #     input.match?(/[0-9]{5}/)
    # end
    
    # def valid_radius_input?(input)# between? didn't work because string, but cover? did
    #     ("1".."500").cover?(input)
    # end
    
    def banner
        puts "* * * * * * * * * * * * * * * * * * *"
        puts "*                                   *"
        puts "*       Welcome to PupFind!         *"
        puts "*     Your new friend awaits!       *"
        puts "*                                   *"
        puts "* * * * * * * * * * * * * * * * * * *"
    end

end
    # hello pseudocode! this will be deleted as functionality is added
    #     #RESPONSE = ["breeds", "age", "gender", "restart", "exit"]
    #     # add fixed?, pup_link, organization
    
    #     def call
#         banner
#         start_menu
#         result_menu if nav_query_valid
#         quit_message
#     end           
#     def result_menu
#         puts "Here are the available puppies within #{mile_radius} miles of #{zip_result_response}!"
#         puts "#{result_index+1}. #{pup_name} || #{pup_breed} || #{pup_gender} || #{pup_age} months || #{zip_distance}" #spay/neutered? ## petfinder doesn't list DOB for age. fuckwads.
#         puts "To refine results, select from criteria: 'breeds' 'age' 'gender'" #write sort
#         puts "To get more information about a puppy, enter the number"
#         puts "To begin a new query, enter 'restart'"
#         puts "To exit, enter 'exit'"
#         puts "What would you like to do?"
#         result_response = gets.strip
#         if result_response.is_a? Integer #and equals result_index+1
#             puppy_bio(result_response) #unless an invalid menu number                 
#         elsif result_response == "breeds"
#             list_breeds
#         elsif result_response == "age"
#             list_ages
#         elsif result_response == "gender"
#             list_genders
#         elsif result_response == "restart"
#             start_menu
#         elsif result_response == "exit"
#             quit_message
#         else
#             puts "Please enter a valid option."
#                 #wait 3 seconds
#             result_menu
#         end
#     end            
          
#     def puppy_bio(result_response)
#         puts "***********************************************************************************************************************"
#         puts "Hi, my name is #{pup_name}! Woof!"
#         puts "I am a #{pup_breed}! My size is considered #{pup_size} sized dog" #make size lower case, make breed first letter capital
#         puts "Based on WhatDog?, I look like a #{whatdog_result}! Makes you think!"
#         puts "I am a #{pup gender}!"
#         puts "I am #{pup_age} months old!"
#         puts "My colors and markings are #{pup_color}!" #split and comma'd if multiple
#         puts "I am located in #{pup_zip}, which is #{zip_distance} miles from you!" #resist urge to city/state
#         puts "You should know that I have the following needs: #{pup_demeanor}" #if, otherwise print none!
#         puts "Here is additional contact info I found! #{pup_email} , #{pup_phone}"
#         puts "If a price was listed, I am available for #{pup_fee}"
#         puts "***********************************************************************************************************************"
#         puts "Enter 'save' to save and export this puppy's information. Enter anything else to return to the previous list of results"
#         bio_response = gets.strip
#             if bio_response = "save"
#                 save_pup
#             else
#                 result_menu
#             end
#         end
#     end
  
#     def save_pup
#         export_current_pup_method
#         if successful?
#             puts "Puppy saved to #{filename}. Make sure to save me somewhere safe!" # or clipboard?
#         else
#             puts "Puppy wasn't able to be saved!" # will make a custom error. clipboard might make this unnecessary
#         end
#         # wait a few seconds
#         result_menu
#         end
#     end          
 
 
#     def quit_message
#         puts "Thank you for using PupFind!"
#     end
# end
# #       .-.                     .-.
# #      (   `-._______________.-'   )
# #       \                         /
# #        >= Welcome to PupFind! =<
# #       /      ______________     \
# #  jgs (   ,-'`              `'-,  )
# #       `-'                      `-'
  