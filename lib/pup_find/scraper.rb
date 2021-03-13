class Scraper
  #apikey not committed, for obvious reasons
  def self.get_pup_hash
    url = "https://api.rescuegroups.org/v5/public/animals/search/available/dogs/"
    pup_response = HTTParty.post(url,
      headers: {"Authorization" => {{APIKEY}}, "Content-Type" =>"application/vnd.api+json"},
      body: "{\n    \"data\": {\n        \"filterRadius\": {\n            \"miles\": 50,\n            \"postalcode\": 11204\n        }\n    }\n}"
      )
  end

  def color_hash
    url = "https://api.rescuegroups.org/v5/public/animals/colors"
    color_response = HTTParty.get(url,
      headers: {"Authorization" => {{APIKEY}}, "Content-Type" =>"application/vnd.api+json"},
      body: "{\n    \"data\": {\n        \"filterRadius\": {\n            \"miles\": 50,\n            \"postalcode\": 11204\n        }\n    }\n}"
      )
   end
   

end