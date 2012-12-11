class Editable
  def self.content_type(name)
    case name
      when /\.(png|gif|jpg|jpeg)\Z/
        "image"
      when /\.css\Z/
        "text/css"
      when /\.js\Z/
        "text/javascript"
      when /\.xml\Z/
        "text/xml"
      when /\.yml\Z/
        "text/yaml"
      when /\.json\Z/
        "application/json"
      when /\.txt\Z/
        "text/plain"
      when /\.(html|htm|xhtml|liquid)\Z/
        "text/html"
      else
        "unknown_type"
    end
  end
end
