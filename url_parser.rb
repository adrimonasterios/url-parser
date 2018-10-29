class UrlParser
  attr_reader :url, :scheme, :domain, :port, :path, :query_string, :fragment_id

  def initialize(url)
    @url=url
  end


  def scheme
    scheme = @url.split(":").first
  end


  def domain
    domain = @url.split("/").drop(2).first.split(":").first
  end


  def port
    port_var = @url.split("/").drop(2).first

    if port_var.include?(":")
      port_var = port_var.split(":").last
    else
      port_var = ""
    end

    if port_var == "" && scheme == "http"
      port_var = "80"
    elsif port_var == "" && scheme == "https"
      port_var = "443"
    else
      port_var
    end
  end


  def path
    path_var = @url.split("/").drop(3).first.split("?").first
    if path_var == ""
      path_var = nil
    else
      path_var
    end
  end


  def query_string
    q_hash={}
    if @url.include?("?")
      @url.split("?").last.split("#").first.split("&").map{ |element| {element.split("=").first => element.split("=").last}}.map{|element| q_hash.merge!(element)}
    else
      q_hash = ""
    end
    q_hash
  end


  def fragment_id
    if @url.include?("#")
    fragment_var = @url.split("#").last
    else
      ""
    end
  end
end


# github_url = UrlParser.new 'http://www.google.com:60/search?q=cat&name=Tim#img=FunnyCat'
# github_url = UrlParser.new 'https://www.google.com/?q=cat#img=FunnyCat'
# github_url = UrlParser.new 'http://www.google.com/search'
# github_url = UrlParser.new 'https://www.google.com/search'
github_url = UrlParser.new 'http://www.google.com:60/search?q=cat&q=overwrite#img=FunnyCat'


puts github_url.url

puts github_url.scheme
# => "https"
puts github_url.domain
# => "github.com"
puts github_url.port
# => "443"
puts github_url.path
# => "search"
puts github_url.query_string
# => {"q" => "ruby"}
puts github_url.fragment_id
# => "stuff"
