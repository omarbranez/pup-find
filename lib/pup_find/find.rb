class Find
#need to account for primary/secondary breeds, primary/secondary colors based on separate color database, age must equal puppy, 
#take in demeanor attributes? parse socials and emails?
  attr_accessor :name, :breed, :ageGroup, :ageString, :color_id, :picture, :sex, :sizeGroup, :org_id, :descrip, :photo_link, :url
  @@all = []
 
  def initialize(hash)
    hash.each do |attribute, value|
      self.send("#{attribute}=", value) #mass assignment as refactor
    end
    #binding.pry 
    @@all << self
  end
  
  def self.all
    @@all
  end

end