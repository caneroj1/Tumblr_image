require 'open-uri'
require 'tumblr_client'

## TUMBLR API OBJECT CLASS. This class handles all of the interfacing with the Tumblr api. The initialize function will open a connection with the
# Tumblr API. The query function executes a query to get 5 images from Tumblr's API from the blog indicated in the url. The create images function makes 
# the images that will be used in the game. They are stored on the user's desktop.

class TumblrAPIObject
  
  ## creates a new Tumblr API Object that is able to pull information from Tumblr's servers
  # the initialize function has a single parameter that will accept a string that is the URL of the desired blog.
  # this function will process and strip down the string into the following format: blogname.tumblr.com/
  def initialize(input)
    # Authenticate via OAuth
    @client = Tumblr::Client.new({
      :consumer_key => 'eYFF887FauAjtA92YZLBwPI0TmYCNrYOyVBGvPD8GOCvkCFyCy',
      :consumer_secret => 'e888vLuYxDwPyWSfGJCfkNOwro8su3LX2CiUTMcZwfop7uhqPM',
      :oauth_token => 'hlBXwpRcylfwZk5ZnTcRMfUxOYb6oQO8P9cnAjcL2PeUlJYaSh',
      :oauth_token_secret => 'oOPzfs94gBGrSa6Fm5BjxZEFWouptnYeB6DbshQuzmsbkx84ao'
    })
    
    # process the parameter string input to convert it into the right format
    # store it in the variable url that will be usd in the query function
    # the regular expression in the sub function will replace urls of the form http://blogname.tumblr.com or http://www.blogname.tumblr.com with
    # blogname.tumblr.com/
    @url = input.downcase.sub(/http:\/\/(www.){,1}/, '')
  end
  
  ## uses the Tumblr API object to request pictures. It pulls 10 pictures right now but is only using 5.
  # for each picture, it finds the url of that image with a width of 250px. it then stores that url in the imageArray.
  # if the query to the Tumblr API was empty, this function returns a 0 indicating an error. If the results were nonempty, 
  # the function returns the number of pictures grabbed.
  def query
    # Make the request
    results = @client.posts(@url, :type => "photo", :limit => 5)
    i = 0

    # if there were no results, return 0 which will give an error in game.rb
    if results.empty?
      return 0
    elsif (results.size != 2) and (results["posts"].size == 5) # results will have a size of two if there was an error with the tumblr API, also need 5 pictures
      @imageArray = Array.new(5)
      begin
      	@imageArray[i] = results["posts"][i]["photos"][0]["alt_sizes"][1]["url"].sub(/_[4-5]00/, '_250') # regular expression will select pictures 250px wide
      	i += 1
      end while i < 5
      return @imageArray.size
    else
      return results.size
    end
  end
  
  ## this function initializes a hash that maps each image to an identifier. we only grabbed 5 images but this function copies each one 
  # to end up with 10 pictures. the function then opens each picture using modulo arithmetic to loop back around.
  # FUTURE GOAL: INSTEAD OF COPYING EACH IMAGE ONCE, CHANGE THIS FUNCTION TO JUST OPEN THE 5 IMAGES.
  def create_images
    imgNames = Hash[
    	File.join(Dir.home, 'Desktop/image1.png') => 0,
    	File.join(Dir.home, 'Desktop/image2.png') => 1,
    	File.join(Dir.home, 'Desktop/image3.png') => 2,
    	File.join(Dir.home, 'Desktop/image4.png') => 3,
    	File.join(Dir.home, 'Desktop/image5.png') => 4,
    	File.join(Dir.home, 'Desktop/image6.png') => 0,
    	File.join(Dir.home, 'Desktop/image7.png') => 1,
    	File.join(Dir.home, 'Desktop/image8.png') => 2,
    	File.join(Dir.home, 'Desktop/image9.png') => 3,
    	File.join(Dir.home, 'Desktop/image10.png') => 4 ]
   	
    i = 0
    imgNames.each_key do |imgN|
      open(imgN, 'wb', 0666) do |file|
        puts "Loading..."
        file << open(@imageArray[i%5]).read
      end
      i += 1
    end
  end
end