require_relative 'gosu.rb'
require_relative 'tumblr.rb'

tumblr = TumblrAPIObject.new
if tumblr.query then
  tumblr.create_images

  window = MyWindow.new(1250, 900)
  window.show
else
  puts "Error"
end