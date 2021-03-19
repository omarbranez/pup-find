class Puppy
  #need to account for primary/secondary breeds, primary/secondary colors based on separate color database, age must equal puppy, 
  #take in demeanor attributes? parse socials and emails?
    attr_accessor :name, :breed, :age, :color_id, :picture, :sex, :size, :org_id, :descrip, :website, :zip_input
    @@all = []
   
    def initialize(hash)
      hash.each do |attribute, value|
        #self.class.attr_accessor(attribute) later for refactoring/expansion?
        self.send("#{attribute}=", value)
      end 
      @@all << self
    end
    
    def self.all
      @@all
    end
  
    def self.create_from_hash(scrape_data)
      scrape_data.each do |result_data|
        Puppy.new(result_data)  
      end
    end
  
  end