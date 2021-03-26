class PupAPI
  
  def self.get_pup_hash(z_input, r_input)
    puppies = []
    url = "https://api.rescuegroups.org/v5/public/animals/search/available/dogs/?limit=250&field[animals]=distance&sort=animals.distance"
    pup_response = HTTParty.post(url,
    headers: {"Authorization" => ENV["API_KEY"], "Content-Type" =>"application/vnd.api+json"},
    body: "{\"data\":{\"filters\":[{\"fieldName\":\"animals.ageGroup\",\"operation\":\"equal\",\"criteria\":\"Baby\"},{\"fieldName\":\"animals.birthDate\",\"operation\":\"notblank\"}],\"filterRadius\":{\"miles\":#{r_input},\"postalcode\":#{z_input}}}}"
    )
    if !pup_response["data"] #if data doesn't exist, then an error popped up. the only error possible on our end is a 400 invalid value (for unusued postcode). 
      begin
        raise ZipError.new(z_input)
        puts error.message
      end
    else
    pup_response["data"].each do |pup| 
      puppies << temp_hash = { #move to Puppy.initialize?
        :id => pup["id"],
        :name => pup["attributes"]["name"],
        :breed => (pup["attributes"]["breedString"] if pup["attributes"]["breedString"]),
        :age => (pup["attributes"]["ageString"] if pup["attributes"]["ageString"]),
        :color_id => (pup["relationships"]["colors"]["data"].first["id"] if pup["relationships"]["colors"]),
        :sex => (pup["attributes"]["sex"] ? pup["attributes"]["sex"] : "Unknown Sex"),
        :size => pup["attributes"]["sizeGroup"],
        :org_id => (pup["relationships"]["orgs"]["data"].first["id"] if pup["relationships"]["orgs"]),
        :descrip => (pup["attributes"]["descriptionText"].gsub("&nbsp", " ").gsub(/\n/," ").gsub("&#39;", "'").gsub(";","").gsub("&rs","'") if pup["attributes"]["descriptionText"]), #need to refactor these gsubs
        :website => pup["attributes"]["url"],
        :distance => pup["attributes"]["distance"]
        }
      end
    end
    puppies
  end
 
  def self.get_color_hash(clr)
    color_hash = []
    url = "https://api.rescuegroups.org/v5/public/animals/colors/#{clr}"
    color_response = HTTParty.get(url,
    headers: {"Authorization" => ENV["API_KEY"], "Content-Type" =>"application/vnd.api+json"})
    color_response["data"].each do |colors| # move to Puppy?
      color_hash << colors["id"]
      color_hash << colors["attributes"]["name"]
    end
    color_hash
  end
 
  def self.get_org_hash(org)
    org_hash = []
    url = "https://api.rescuegroups.org/v5/public/orgs/#{org}"
    org_response = HTTParty.get(url,
    headers: {"Authorization" => ENV["API_KEY"], "Content-Type" =>"application/vnd.api+json"})
    unless org_response["data"] == nil
      org_response["data"].each do |organization| # move to Puppy?
        org_hash << organization["id"]
        org_hash << (organization["attributes"]["name"] ? organization["attributes"]["name"] : "Unknown")
        org_hash << (organization["attributes"]["city"] ? organization["attributes"]["city"] : "Unknown")
        org_hash << (organization["attributes"]["state"] ? organization["attributes"]["state"] : "Unknown")
        org_hash << (organization["attributes"]["email"] ? organization["attributes"]["email"] : "Unknown")
        org_hash << (organization["attributes"]["url"] ? organization["attributes"]["url"] : "Unknown")
        org_hash << (organization["attributes"]["adoptionProcess"] ? organization["attributes"]["adoptionProcess"] : "Unknown")
        org_hash << (organization["attributes"]["about"] ? organization["attributes"]["about"] : "Unknown")
      end
    end
    org_hash
  end

  class ZipError < StandardError

    attr_reader :input

    def initialize(input) 
      @input = input
    end

    def message
      "The zip code you have entered is invalid. Please try again."
    end

  end

end