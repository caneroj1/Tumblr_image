require 'tumblr_client'

# Authenticate via OAuth
client = Tumblr::Client.new({
  :consumer_key => 'eYFF887FauAjtA92YZLBwPI0TmYCNrYOyVBGvPD8GOCvkCFyCy',
  :consumer_secret => 'e888vLuYxDwPyWSfGJCfkNOwro8su3LX2CiUTMcZwfop7uhqPM',
  :oauth_token => 'hlBXwpRcylfwZk5ZnTcRMfUxOYb6oQO8P9cnAjcL2PeUlJYaSh',
  :oauth_token_secret => 'oOPzfs94gBGrSa6Fm5BjxZEFWouptnYeB6DbshQuzmsbkx84ao'
})

# Make the request
h = client.posts("codingjester.tumblr.com", :type => "photo", :limit => 10)
i = 0

imageArray = Array.new(5)
begin
	imageArray[i] = h["posts"][i]["photos"][0]["alt_sizes"][1]["url"].sub(/_[4-5]00/, '_250')
	i += 1
end while i < 5

imgNames = [
   	'image1.png',
   	'image2.png',
   	'image3.png',
   	'image4.png',
   	'image5.png',
   	'image6.png',
   	'image7.png',
   	'image8.png',
   	'image9.png',
   	'image10.png']
   	
i = 0
imgNames.each do |imgN|
 open(imgN, 'wb') do |file|
  puts i%5
  file << open(imageArray[i%5]).read
 end
 i += 1
end