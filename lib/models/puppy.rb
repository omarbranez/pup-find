class Puppy
  attr_accessor :id, :name, :breed, :age, :color_id, :sex, :size, :org_id, :descrip, :website, :distance, :org, :colors
  @@all = []
  
  def initialize(hash)
    @id = hash["id"] 
    @name = hash["attributes"]["name"]
    @breed = (hash["attributes"]["breedString"] if hash["attributes"]["breedString"])
    @age = (hash["attributes"]["ageString"] if hash["attributes"]["ageString"])
    @color_id = (hash["relationships"]["colors"]["data"].first["id"] if hash["relationships"]["colors"])
    @sex = (hash["attributes"]["sex"] ? hash["attributes"]["sex"] : "Unknown Sex")
    @size = (hash["attributes"]["sizeGroup"] ? hash["attributes"]["sizeGroup"] : "Unknown")
    @org_id = (hash["relationships"]["orgs"]["data"].first["id"] if hash["relationships"]["orgs"])
    @descrip = (hash["attributes"]["descriptionText"].gsub("&nbsp", "").gsub(/\n/,"").gsub("&#39;", "'").gsub(";","").gsub("&rs","'").strip if hash["attributes"]["descriptionText"]) #need to refactor these gsubs
    @website = hash["attributes"]["url"]
    @distance = hash["attributes"]["distance"]
    @@all << self
  end
   
  def self.all
    @@all
  end
  
  def self.create_puppies(pup_hash)
    pup_hash.each do |puppies|
      Puppy.new(puppies) 
    end
  end

  def to_pup_hash
    {@name + " || " + @breed + " || " + @sex + " || " + @age + " old || " + @distance.to_s + " miles away ||" => @id}
  end

  def to_breed_hash
    {@breed + " || " + @name + " || " + @sex + " || " + @age + " old || " + @distance.to_s + " miles away ||" => @id}
  end

  def to_size_hash
    {@size + " || " + @breed + " || " + @name + " || " + @sex + " || " + @age + " old || " + @distance.to_s + " miles away ||" => @id}
  end

  def attach_color(color_input)
    @color = Colors.create_color(color_input)
  end

  def attach_org(org_input) 
    Org.create_org(org_input)
    Org.all.first.instance_variables.each do |var|
      self.instance_variable_set(var, Org.all.first.instance_variable_get(var))
    end 
  end

  def puppy_bio 
    system "clear"
    self.attach_color(@color_id)
    self.attach_org(@org_id)
    puts "***********************************************************************************************************************"
    puts "Hi, my name is #{@name}! Woof!"
    puts "I am a #{@breed}! I will grow into a #{@size} sized dog!" 
    puts "I am a #{@sex}!"
    puts "I am #{@age} old!"
    puts "My color and markings are #{@color}!"
    puts "I am located in #{@org_city}, #{@org_state}, which is #{@distance} miles from you!"
    puts "A little about me:"
    puts "#{@descrip}"
    puts @website ? "You can find more information about me at: #{@website}" : "Please visit #{@org_site} to find more information about me."
    puts "***********************************************************************************************************************"
  end

end 