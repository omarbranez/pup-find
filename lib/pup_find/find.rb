class Find
#need to account for primary/secondary breeds, primary/secondary colors based on separate color database, age must equal puppy, 
#take in demeanor attributes? parse socials and emails?
  attr_accessor :name, :breed, :ageString, :color_id, :picture, :sex, :sizeGroup, :org_id, :descrip, :photo_link, :url, :zip_input
  @@all = []
 
  def initialize(hash)
    hash.each do |attribute, value|
      #self.class.attr_accessor(attribute) later for refactoring?
      self.send("#{attribute}=", value)
    end 
      #binding.pry 
    @@all << self
  end
  
  def self.all
    @@all
  end

  ## not needed, or at least yet
  def self.create_from_hash(hash)
    pup_scrape_hash.each do |new_hash|
      Find.new(new_hash)  
    end
  end

end
