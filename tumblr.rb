require 'open-uri'
require 'tumblr_client'

class TumblrAPIObject
  
  def initialize
    # Authenticate via OAuth
    @client = Tumblr::Client.new({
      :consumer_key => 'eYFF887FauAjtA92YZLBwPI0TmYCNrYOyVBGvPD8GOCvkCFyCy',
      :consumer_secret => 'e888vLuYxDwPyWSfGJCfkNOwro8su3LX2CiUTMcZwfop7uhqPM',
      :oauth_token => 'hlBXwpRcylfwZk5ZnTcRMfUxOYb6oQO8P9cnAjcL2PeUlJYaSh',
      :oauth_token_secret => 'oOPzfs94gBGrSa6Fm5BjxZEFWouptnYeB6DbshQuzmsbkx84ao'
    })
  end
  
  def query
    # Make the request
    results = @client.posts("codingjester.tumblr.com/", :type => "photo", :limit => 10)
    i = 0
    
    if results.empty?
      return false
    else
      @imageArray = Array.new(5)
      begin
      	@imageArray[i] = results["posts"][i]["photos"][0]["alt_sizes"][1]["url"].sub(/_[4-5]00/, '_250')
      	i += 1
      end while i < 5
      return true
    end
  end
  
  def create_images
    imgNames = Hash[
       	'image1.png' => 0,
       	'image2.png' => 1,
       	'image3.png' => 2,
       	'image4.png' => 3,
       	'image5.png' => 4,
       	'image6.png' => 0,
       	'image7.png' => 1,
       	'image8.png' => 2,
       	'image9.png' => 3,
       	'image10.png' => 4 ]
   	
    i = 0
    imgNames.each_key do |imgN|
      open(imgN, 'wb') do |file|
        puts i%5
        file << open(@imageArray[i%5]).read
      end
      i += 1
    end
  end
end