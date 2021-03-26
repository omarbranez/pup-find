class Puppy

  attr_accessor :name, :breed, :age, :color_id, :sex, :size, :org_id, :descrip, :website, :user_zip, :color, :distance, :org_hash, :id
  @@all = []
  
  def initialize(hash)
    hash.each do |attribute, value|
      #self.class.attr_accessor(attribute) #later for refactoring/expansion?
      self.send("#{attribute}=", value)
    end
    @@all << self
  end
   
  def self.all
    @@all
  end
  
  def self.create_puppies(pup_array)
    pup_array.each do |puppies|
      Puppy.new(puppies) 
    end
  end

  def to_pup_hash
    {@name + " || " + @breed + " || " + @sex + " || " + @age + " old || " + @distance.to_s + " miles away ||" => @id}
  end

  def to_breed_hash
    {@breed + " || " + @name  + " || " + @sex + " || " + @age + " old || " => @id}
  end

  def self.get_puppies
    PupAPI.get_pup_hash(zip_input)
    all
  end
  
  def self.find_by_attribute(attribute)
    self.all.find{|puppy| puppy.attribute == attribute}
  end

  def puppy_bio #move to CLI?
    system "clear"
    color_data = PupAPI.get_color_hash(color_id)    
    org_data = PupAPI.get_org_hash(org_id)
    puts "***********************************************************************************************************************"
    puts "Hi, my name is #{@name}! Woof!"
    puts "I am a #{@breed}! I will grow into a #{@size} sized dog!" 
    puts "I am a #{@sex}!"
    puts "I am #{@age} old!"
    if @color_id
      puts "My color and markings are #{color_data[1]}!"
    else puts "My color and markings are Unlisted"
    end
    puts "I am located in #{org_data[2]}, #{org_data[3]}, which is #{@distance} miles from you!" #resist urge to city/state
    #puts "If a price was listed, I am available for #{pup_fee}"
    puts "A little about me:"
    puts "#{@descrip}"
    if @website
      puts "You can find more information about me at: #{@website}"
      else puts "Please visit #{org_data[5]} to find more information about me." # at least one puppy didn't have a website, but the rescue had one. i hope a puppy SOMEWHERE isn't lacking both.
    end
    puts "***********************************************************************************************************************"
  end

  def rescue_bio # will probably require a new class of Rescue
    system "clear"
    org_data = PupAPI.get_org_hash(org_id)
    puts "***********************************************************************************************************************"
    puts "Rescue Name: #{org_data[1]}" 
    puts "Location: #{org_data[2]}, #{org_data[3]}"
    puts "Email: #{org_data[4]}"
    puts "Website: #{org_data[5]}"
    puts "Adoption Process: #{org_data[6]}"
    puts "Rescue Information: #{org_data[7].gsub("&nbsp", " ").gsub(/\n/," ").gsub("&#39;", "'").gsub(";","")}"
    puts "***********************************************************************************************************************"
  end

end 