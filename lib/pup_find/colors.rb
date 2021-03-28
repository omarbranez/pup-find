class Colors
    attr_reader :color_id

    def self.create_color(color_input)
        color_input == nil ? "Unknown or Unlisted" : PupAPI.get_color_hash(color_input)["name"]
    end

end