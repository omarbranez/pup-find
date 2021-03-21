class Puppy
  #take in demeanor attributes? parse socials and emails? 
  attr_accessor :name, :breed, :age, :color_id, :picture, :sex, :size, :org_id, :descrip, :website, :user_zip, :color 
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
 
  def add_pup_colors(color_hash) 
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
    puts "***********************************************************************************************************************" 
    puts "Hi, my name is #{self.name}! Woof!" 
    puts "I am a #{self.breed}! I will grow into a #{self.size} sized dog" #make size lower case, make breed first letter capital 
    #puts "Based on WhatDog?, I look like a #{whatdog_result}! Makes you think!" 
    puts "I am a #{self.sex}!" 
    puts "I am #{self.age} old!" 
    puts "My colors and markings are #{self.color}!" 
    #puts "I am located in #{self.pup_zip}, which is #{self.distance} miles from you!" #resist urge to city/state 
    #puts "You should know that I have the following needs: #{pup_demeanor}" #if, otherwise print none! 
    #puts "If a price was listed, I am available for #{pup_fee}" 
    puts "A little about me:" 
    puts "#{self.descrip}" 
    puts "You can find more information about me at #{self.website}" 
    puts "***********************************************************************************************************************" 
    puts "Type 'results' to be returned to the previous results. Type 'quit' to leave PupFind." 
  end
  
end
 
 