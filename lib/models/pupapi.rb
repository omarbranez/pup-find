class PupAPI
  
  def self.get_pup_hash(z_input, r_input)
    url = "https://api.rescuegroups.org/v5/public/animals/search/available/dogs/?limit=250&field[animals]=distance&sort=animals.distance"
    pup_response = HTTParty.post(url,
    headers: {"Authorization" => ENV["API_KEY"], "Content-Type" =>"application/vnd.api+json"},
    body: "{\"data\":{\"filters\":[{\"fieldName\":\"animals.ageGroup\",\"operation\":\"equal\",\"criteria\":\"Baby\"},{\"fieldName\":\"animals.birthDate\",\"operation\":\"notblank\"}],\"filterRadius\":{\"miles\":#{r_input},\"postalcode\":#{z_input}}}}"
    )
    pup_hash = pup_response["data"]
  end
 
  def self.get_color_hash(clr)
    url = "https://api.rescuegroups.org/v5/public/animals/colors/#{clr}"
    color_response = HTTParty.get(url, headers: {"Authorization" => ENV["API_KEY"], "Content-Type" =>"application/vnd.api+json"})         
    color_hash = color_response["data"].first["attributes"]
  end
 
  def self.get_org_hash(org)
    url = "https://api.rescuegroups.org/v5/public/orgs/#{org}"
    org_response = HTTParty.get(url, headers: {"Authorization" => ENV["API_KEY"], "Content-Type" =>"application/vnd.api+json"})
    org_response["data"] != nil ? org_hash = org_response["data"].first["attributes"] : org_hash = nil
  end

end