require_relative 'gosu.rb'
require_relative 'tumblr.rb'

class Game

  ## this function will accept the parameters that will decide the dimensions of the game window
  def initialize(w, h) # dimensions of 1250 x 900 are appropriate
    @width = w
    @height = h
  end
  
  ## this function will initialize the gaming by asking the user which blogs they want to pull pictures from. there will be error checking in the
  # tumblr.rb file. if there is an error the game will exit and display an error message. if everything succeeds the game will begin and go until the user wins,
  # loses, or decides to exit
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
  
  ## this function will delete all of the files that have been created to play the game.
  def delete
    File.delete("image1.png",
                "image2.png",
                "image3.png",
                "image4.png",
                "image5.png",
                "image6.png",
                "image7.png",
                "image8.png",
                "image9.png",
                "image10.png",
    )
  end
end