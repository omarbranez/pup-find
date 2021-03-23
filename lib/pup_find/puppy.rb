class Puppy
  #take in demeanor attributes? parse socials and emails?
  attr_accessor :name, :breed, :age, :color_id, :picture, :sex, :size, :org_id, :descrip, :website, :user_zip, :color, :distance, :org_hash, :id
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
    {self.name + " || " + self.breed + " || " + self.sex + " || " + self.age + " old ||"  => self.id}
    #binding.pry
  end

  
  def add_pup_colors(color_hash) # possibly deprecated, pull on pup basis to reduce menu lag just like org
    color_hash.each do |key, value|
      if key == self.color_id
        self.color = value
      end
    end
  end
  
  def self.get_puppies
    Scraper.get_pup_hash(zip_input)
    all
  end
  
  def self.find_by_name(name)
    self.all.find{|puppy| puppy.name == name}
  end
  
  def puppy_bio #nils should be "Unknown" #move to CLI?
    org_data = Scraper.get_org_hash(org_id)
    puts "***********************************************************************************************************************"
    puts "Hi, my name is #{self.name}! Woof!"
    puts "I am a #{self.breed}! I will grow into a #{self.size} sized dog" #make size lower case, make breed first letter capital
    #puts "Based on WhatDog?, I look like a #{whatdog_result}! Makes you think!"
    puts "I am a #{self.sex}!"
    puts "I am #{self.age} old!"
    puts "My colors and markings are #{self.color}!"
    puts "I am located in #{org_data[2]}, #{org_data[3]}, which is #{self.distance} miles from you!" #resist urge to city/state
    #puts "You should know that I have the following needs: #{pup_demeanor}" #if, otherwise print none!
    #puts "If a price was listed, I am available for #{pup_fee}"
    puts "A little about me:"
    puts "#{self.descrip}"
      if self.website
    puts "You can find more information about me at: #{self.website}"
      else puts "Please visit #{org_data[5]} to find more information about me."
      end
    puts "***********************************************************************************************************************"
  end

  def rescue_bio # will probably require a new class of Rescue
    org_data = Scraper.get_org_hash(org_id)
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
 