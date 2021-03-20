class Scraper 
  
  def self.get_pup_hash(input)
    url = "https://api.rescuegroups.org/v5/public/animals/search/available/dogs/?limit=50&field[animals]=distance&sort=animals.distance"
    pup_response = HTTParty.post(url,
    headers: {"Authorization" => APIKEY, "Content-Type" =>"application/vnd.api+json"},
    body: "{\"data\":{\"filters\":[{\"fieldName\":\"animals.ageGroup\",\"operation\":\"equal\",\"criteria\":\"Baby\"},{\"fieldName\":\"animals.birthDate\",\"operation\":\"notblank\"}],\"filterRadius\":{\"miles\":500,\"postalcode\":#{input}}}}"
    ) 
    puppies = []
    pup_response["data"].each do |pup| # need to check if exists, otherwise will return nomethoderror. see: relationships, and one case of descrip
      puppies << temp_hash = {
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

  def color_hash(input1, input2)
    url = "https://api.rescuegroups.org/v5/public/animals/colors"
    color_response = HTTParty.get(url,
      headers: {"Authorization" => APIKEY, "Content-Type" =>"application/vnd.api+json"},
      body: "{\n    \"data\": {\n        \"filterRadius\": {\n            \"miles\":500,\n            \"postalcode\": #{zip_input}\n        }\n    }\n}"
      )
   end
   
end