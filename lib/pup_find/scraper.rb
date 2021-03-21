
class Scraper
  
  def self.get_pup_hash(input) 
    puppies = [] 
    url = "https://api.rescuegroups.org/v5/public/animals/search/available/dogs/?limit=100&field[animals]=distance&sort=animals.distance"
    pup_response = HTTParty.post(url,
    headers: {"Authorization" => APIKEY, "Content-Type" =>"application/vnd.api+json"}, 
    body: "{\"data\":{\"filters\":[{\"fieldName\":\"animals.ageGroup\",\"operation\":\"equal\",\"criteria\":\"Baby\"},{\"fieldName\":\"animals.birthDate\",\"operation\":\"notblank\"}],\"filterRadius\":{\"miles\":500,\"postalcode\":#{input}}}}")
    pup_response["data"].each do |pup| # need to check if exists, otherwise will return nomethoderror. see: relationships, and one case of descrip 
      puppies << temp_hash = { #move to Puppy.initialize? 
        :name => pup["attributes"]["name"], 
        :breed => pup["attributes"]["breedString"], 
        :age => pup["attributes"]["ageString"], 
        :color_id => (pup["relationships"]["colors"]["data"].first["id"] if pup["relationships"]["colors"]), 
        :sex => pup["attributes"]["sex"], 
        :size => pup["attributes"]["sizeGroup"], 
        :org_id => (pup["relationships"]["orgs"]["data"].first["id"] if pup["relationships"]["orgs"]), 
        :descrip => (pup["attributes"]["descriptionText"].gsub("&nbsp", " ").gsub(/\n/," ").gsub("&#39;", "'").gsub(";","") if pup["attributes"]["descriptionText"]), #need to refactor these gsubs
        :website => pup["attributes"]["url"] 
      } 
      puppies.first[:user_zip] = input 
    end 
    puppies 
  end 
 
  def self.get_color_hash 
    color_hash = [] 
    url = "https://api.rescuegroups.org/v5/public/animals/species/8/colors/?limit=40" 
    color_response = HTTParty.get(url, 
    headers: {"Authorization" => APIKEY, "Content-Type" =>"application/vnd.api+json"}) 
    color_response["data"].each do |colors| # move to Puppy? 
      color_hash << colors["id"] 
      color_hash << colors["attributes"]["name"] 
    end 
    color_hash = Hash[*color_hash] # splat the hash, teehee 
  end
 
  def org_hash 
  end 
 
  def breed_hash 
  end 
 
 end
 
 