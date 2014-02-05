require_relative 'gosu.rb'
require_relative 'tumblr.rb'

class Game

  def initialize(w, h) # dimensions of 1250 x 900 are appropriate
    @width = w
    @height = h
  end
  
  def start
    # ask for user input to get the blog name
    puts "Enter the name of the blog: "
    blogName = gets.chop

    if blogName.empty? then 
      puts "Error: Please enter a Tumblr blog name."
    else
      ## create a new TumblrAPIObject so we can issue calls to the tumblr api for data
      tumblr = TumblrAPIObject.new(blogName)

      ## query the API. if there were enough results then advance, else issue an error
      if (tumblr.query == 5) then
        tumblr.create_images                                # create and save the images for the game

        window = MyWindow.new(@width, @height)              # start the game
        window.show
      else
        puts "Error downloading pictures from Tumblr. Please check your internet connection or the blog name you entered. Blogs need at least 5 pictures."
      end
    end
  end
end