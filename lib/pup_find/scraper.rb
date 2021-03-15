class Scraper 
  
  def self.get_pup_hash(input1, input2)
    url = "https://api.rescuegroups.org/v5/public/animals/search/available/dogs/"
    #binding.pry
    pup_response = HTTParty.post(url,
    headers: {"Authorization" => APIKEY, "Content-Type" =>"application/vnd.api+json"},
    body: "{\n    \"data\": {\n        \"filterRadius\": {\n            \"miles\":#{input2},\n            \"postalcode\":#{input1}\n        }\n    }\n}"
    )
    pup_scrape_hash = {
      name: pup_response["data"][0]["attributes"]["name"], #data is an array of hashes
      breed: pup_response["data"][0]["attributes"]["breedString"],
      ageGroup: pup_response["data"][0]["attributes"]["ageGroup"],
      ageString: pup_response["data"][0]["attributes"]["ageString"],
      color_id: pup_response["data"][0]["relationships"]["colors"]["data"][0]["id"],
      picture: pup_response["data"][0]["attributes"]["pictureThumbnailUrl"],
      sex: pup_response["data"][0]["attributes"]["sex"],
      sizeGroup: pup_response["data"][0]["attributes"]["sizeGroup"],
      org_id: pup_response["data"][0]["relationships"]["orgs"]["data"][0]["id"],
      descrip: pup_response["data"][0]["attributes"]["descriptionText"].gsub("&nbsp", " ").gsub(/\n/," "),
      photo_link: pup_response["data"][0]["attributes"]["pictureThumbnailUrl"],
      url: pup_response["data"][0]["attributes"]["url"]   
    } #this api doesn't store the colors and organizations in the same db as the animals. separate search?
    Find.new(pup_scrape_hash)   
    #binding.pry
  end
  
  def color_hash(input1, input2)
    url = "https://api.rescuegroups.org/v5/public/animals/colors"
    color_response = HTTParty.get(url,
      headers: {"Authorization" => APIKEY, "Content-Type" =>"application/vnd.api+json"},
      body: "{\n    \"data\": {\n        \"filterRadius\": {\n            \"miles\": #{zip_radius},\n            \"postalcode\": #{zip_input}\n        }\n    }\n}"
      )
   end
   
end