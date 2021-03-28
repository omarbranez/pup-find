class Org
    attr_accessor :org_name, :org_city, :org_state, :org_email, :org_site, :org_process, :org_about
    @@all = []
    
    def initialize(hash)
        @org_name = (hash["name"] ? hash["name"] : "Unknown")
        @org_city = (hash["city"] ? hash["city"] : "Unknown")
        @org_state = (hash["state"] ? hash["state"] : "Unknown")
        @org_email = (hash["email"] ? hash["email"] : "Unknown")
        @org_site = (hash["url"] ? hash["url"] : "Unknown")
        @org_process = (hash["adoptionProcess"] ? hash["adoptionProcess"].strip : "Unknown")
        @org_about = (hash["about"] ? hash["about"] : "Unknown")
        @@all << self
    end
    
    def self.all
        @@all
    end

    def self.create_org(org_input)
        PupAPI.get_org_hash(org_input) == nil ? Org.new("") : Org.new(PupAPI.get_org_hash(org_input))
    end

    def org_bio 
        system "clear"
        puts "***********************************************************************************************************************"
        puts "Rescue Name: #{@org_name}" 
        puts "Location: #{@org_city}, #{@org_state}"
        puts "Email: #{@org_email}"
        puts "Website: #{@org_site}"
        puts "Adoption Process: #{@org_process}"
        puts "Rescue Information: #{@org_about.gsub("&nbsp", "").gsub(/\n/,"").gsub("&#39;", "'").gsub(";","")}"
        puts "***********************************************************************************************************************"
    end

end