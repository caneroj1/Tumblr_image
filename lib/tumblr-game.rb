require_relative 'tumblr-game/gosu.rb'
require_relative 'tumblr-game/tumblr.rb'


## GAME CLASS. This class takes care of getting user input from the user, passing it to the appropriate class for error checking, starting the game,
# and ending the game. A Game object must be created. The user must then call the initialize function, pass it the parameters, and then call start.
# Those three steps are all that is necessary to start the game. 

class Game

  ## this function will accept the dimensions of the window to be created and initialize a Game object
  def initialize(w, h) # dimensions of 1250 x 900 are appropriate
    @width = w
    @height = h
  end
  
  ## this function will get the name of the blog from the user, and attempt to use the Tumblr API to query for pictures.
  # if there is an error with the user input, say if it is empty or the blog is invalid, the game ends. the user must then re-execute the ruby file
  def start
    # ask for user input to get the blog name
    puts "Enter the name of the blog: "
    blogName = gets.chop.strip

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
        self.delete
      else
        puts "Error downloading pictures from Tumblr. Please check your internet connection or the blog name you entered. Blogs need at least 5 pictures."
      end
    end
  end
  
  ## this function will delete the files that have been made over the course of the game. this function is automatically called by this class after the
  # window is closed
  def delete
    File.delete( File.join(Dir.home, 'Desktop/image1.png'),
                 File.join(Dir.home, 'Desktop/image2.png'),
                 File.join(Dir.home, 'Desktop/image3.png'),
                 File.join(Dir.home, 'Desktop/image4.png'),
                 File.join(Dir.home, 'Desktop/image5.png'),
                 File.join(Dir.home, 'Desktop/image6.png'),
                 File.join(Dir.home, 'Desktop/image7.png'),
                 File.join(Dir.home, 'Desktop/image8.png'),
                 File.join(Dir.home, 'Desktop/image9.png'),
                 File.join(Dir.home, 'Desktop/image10.png')
    )
  end
end