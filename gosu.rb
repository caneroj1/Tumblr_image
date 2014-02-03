require 'gosu'
require_relative 'board.rb'
require_relative 'tile.rb'
require_relative 'timer.rb'

class MyWindow < Gosu::Window
  
  ## constants that will represent the background color for the window when the user loses
  LTOP_COLOR = Gosu::Color.new(255, 225, 100, 100)
  LBOTTOM_COLOR = Gosu::Color.new(255, 200, 125, 125)
  
  ## constants that will represent the background color for the window when the user wins
  WTOP_COLOR = Gosu::Color.new(255, 100, 225, 100)
  WBOTTOM_COLOR = Gosu::Color.new(255, 125, 225, 125)
  
  ## constants that will represent the background color for the window
  TOP_COLOR = Gosu::Color.new(255, 44, 71, 98)
  BOTTOM_COLOR = Gosu::Color.new(255, 125, 125, 125)

  def initialize(w, h)
  
   ## define variables for the width and height of the window
   @width = w
   @height = h  
   
   ## variables for WIN or LOSE state
   @win = false
   @lose = false  
   
   ## initialize the window and caption it
   super(@width, @height, false) 
   self.caption = 'Tumblr Image Match!'
   
   ## define a variable that indicates what state the game is in
   # when phase = 0, that indicates that the user is in the "picking" stage of the game and is selecting a face down card for an
   # initial guess
   # when phase = 1, that indicates that the user is in the "matching" stage of the game and is selecting another card to see if it
   # matches the previous one. after the user clicks the mouse, the images will be shown and then they will be left face up if they match,
   # otherwise both cards will go back to facedown. phase is always set to 0 after this stage.
   @phase = 0
   @frameCounter = 0
   
   ## define two variables that indicates the ID of the first card that was selected when phase was 0 and the ID of the second card selected when 
   # phase = 1
   @picked = 0
   @picked2 = 0
   
   # variable that indicates the second card was actually picked
   @pickedSecond = false
	
   ## initialize a Timer object that will keep track of the time remaining for the given game
   # also create a Gosu font object that will be passed to the Timer object
   font = Gosu::Font.new(self, Gosu::default_font_name, 20)
   @timer = Timer.new(font, @width/2, @height/2)
   
   ## create a font for the end of the game, either win or lose
   @endFont = Gosu::Font.new(self, Gosu::default_font_name, 20)
  
   # create a pseudorandom number generator for shuffling
   prng = Random.new(Random.new_seed())
   
   # create a hash of the image names that we are using along with their associated id
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
   
   ## Durstenfield's Shuffling Algorithm 
   # convert the hash from above into a two-dimensional array that will be shuffled in order to
   # randomize the appearance of the images on the board
   imgArr = imgNames.to_a
   for i in(9).downto(1)
     j = prng.rand(i)
     tempK = imgArr[i][0]
     tempV = imgArr[i][1]
     imgArr[i][0] = imgArr[j][0]
     imgArr[i][1] = imgArr[j][1]
     imgArr[j][0] = tempK
     imgArr[j][1] = tempV
   end
   
   # create the Gosu images so they can be put in to each Tile object
   chk = Gosu::Image.new(self, "check.png", true)
   img0 = Gosu::Image.new(self, "tumblr.png", true) #the back of each card
   img1 = Gosu::Image.new(self, imgArr[0][0], true)
   img2 = Gosu::Image.new(self, imgArr[1][0], true)
   img3 = Gosu::Image.new(self, imgArr[2][0], true)
   img4 = Gosu::Image.new(self, imgArr[3][0], true)
   img5 = Gosu::Image.new(self, imgArr[4][0], true)
   img6 = Gosu::Image.new(self, imgArr[5][0], true)
   img7 = Gosu::Image.new(self, imgArr[6][0], true)
   img8 = Gosu::Image.new(self, imgArr[7][0], true)
   img9 = Gosu::Image.new(self, imgArr[8][0], true)
   img10 = Gosu::Image.new(self, imgArr[9][0], true)
   
   # initialize the game board with the tile objects
   @game_board = Board.new( Tile.new(img1, 0, 0, img0, imgArr[0][1], chk), 
   							Tile.new(img2, 250, 0, img0, imgArr[1][1], chk), 
   							Tile.new(img3, 500, 0, img0, imgArr[2][1], chk), 
   							Tile.new(img4, 750, 0, img0, imgArr[3][1], chk), 
   							Tile.new(img5, 1000, 0, img0, imgArr[4][1], chk), 
   							Tile.new(img6, 0, 500, img0, imgArr[5][1], chk), 
   							Tile.new(img7, 250, 500, img0, imgArr[6][1], chk), 
   							Tile.new(img8, 500, 500, img0, imgArr[7][1], chk), 
   							Tile.new(img9, 750, 500, img0, imgArr[8][1], chk), 
   							Tile.new(img10, 1000, 500, img0, imgArr[9][1], chk) )
  end
  
  ## update function. this function contains all of the game logic
  def update
  	## only allow the user to pick tiles if the frameCounter is at 0
  	# this means that the user can only pick tiles when two tiles are not being displayed
  	# after the 96 frames of display are over, we then call the check_match function and set the frameCounter back to 0 
    if @frameCounter == 0 then 
  		pick_tiles	
  	elsif @frameCounter == 96 then
  		check_match
      check_win
  	 	@frameCounter = 0
  	end
  	
  	## if the user has picked their second tile then we increment the frame counter to display both of them for a few seconds
  	if @phase == 1 and @pickedSecond then
  	 @frameCounter += 1
  	end
    
    ## update the Timer object
    @timer.update
  end
  
  ## draw function. this function will draw one of the three backgrounds for the game. if the game is in the LOSE state, if the time has run out and the
  # player has not matched 5 tiles, the player loses. if the player matches 5 tiles before the time runs out, then they win. else, the regular game
  # board is drawn for the user to play on
  def draw
    if (!@win and @lose) or (@frameCounter == 0 and @game_board.return_count < 5 and @timer.return_time == 0)
      draw_lose
    elsif (@win and !@lose)
      draw_win
    elsif (!@win and !@lose)
      draw_background
      @game_board.draw_board
      @timer.draw  
    end
  end
  
  ## pick_tiles function
  # this function has two parts. if the game is in phase 0, the user is picking an initial tile. the function will check the location
  # of the user's mouse and flip the appropriate tile and keep track of which tile was flipped. then, the game is set to phase 1.
  # in phase 1, the user is picking the tile they want to match with the first one. if a tile is successfully picked, the pickedSecond
  # variable is set to true and the game stores which tile was picked and flipped.
  def pick_tiles
    if button_down? Gosu::KbEscape then
      close
    end
  	if @phase == 0 
  		if button_down? Gosu::MsLeft then
  			# TILE 1
  			if (mouse_x >= 0 and mouse_x <= 250) and (mouse_y >= 0 and mouse_y <= 250) and (!@game_board.is_matched(0)) then
  				@game_board.flip_tile(0, true)
  				@picked = 0
  				@phase = 1
  			# TILE 2
  			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y >= 0 and mouse_y <= 250) and (!@game_board.is_matched(1)) then
  				@game_board.flip_tile(1, true)
  				@picked = 1
  				@phase = 1
  			# TILE 3
  			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y >= 0 and mouse_y <= 250) and (!@game_board.is_matched(2)) then
  				@game_board.flip_tile(2, true)
  				@picked = 2
  				@phase = 1
  			# TILE 4
  			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y >= 0 and mouse_y <= 250) and (!@game_board.is_matched(3))then
  				@game_board.flip_tile(3, true)
  				@picked = 3
  				@phase = 1
  			# TILE 5
  			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y >= 0 and mouse_y <= 250) and (!@game_board.is_matched(4)) then
  				@game_board.flip_tile(4, true)
  				@picked = 4
  				@phase = 1
  			# TILE 6
  			elsif (mouse_x >= 0 and mouse_x <= 250) and (mouse_y > 500 and mouse_y <= 750) and (!@game_board.is_matched(5)) then
  				@game_board.flip_tile(5, true)
  				@picked = 5
  				@phase = 1
  			# TILE 7
  			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y > 500 and mouse_y <= 750) and (!@game_board.is_matched(6)) then
  				@game_board.flip_tile(6, true)
  				@picked = 6
  				@phase = 1
  			# TILE 8
  			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y > 500 and mouse_y <= 750) and (!@game_board.is_matched(7)) then
  				@game_board.flip_tile(7, true)
  				@picked = 7
  				@phase = 1
  			# TILE 9
  			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y > 500 and mouse_y <= 750) and (!@game_board.is_matched(8)) then
  				@game_board.flip_tile(8, true)
  				@picked = 8
  				@phase = 1
  			# TILE 10
  			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y > 500 and mouse_y <= 750) and (!@game_board.is_matched(9)) then
  				@game_board.flip_tile(9, true)
  				@picked = 9
  				@phase = 1
  			end
  			sleep(0.2) # needs delay because gosu's mouse click event seems to be hyper sensitive and picks up multiple clicks instead of 1
  		end
  	else @phase == 1
  		if button_down? Gosu::MsLeft then
    		# TILE 1
  			if (mouse_x >= 0 and mouse_x <= 250) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 0) and (!@game_board.is_matched(0)) then
  				@game_board.flip_tile(0, true)
  				@picked2 = 0
  				@pickedSecond = true
  			# TILE 2
  			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 1) and (!@game_board.is_matched(1)) then
  				@game_board.flip_tile(1, true)
  				@picked2 = 1
  				@pickedSecond = true
  			# TILE 3
  			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 2) and (!@game_board.is_matched(2)) then
  				@game_board.flip_tile(2, true)
  				@picked2 = 2
  				@pickedSecond = true
  			# TILE 4
  			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 3) and (!@game_board.is_matched(3)) then
  				@game_board.flip_tile(3, true)
  				@picked2 = 3
  				@pickedSecond = true
  			# TILE 5
  			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 4) and (!@game_board.is_matched(4)) then
  				@game_board.flip_tile(4, true)
  				@picked2 = 4
  				@pickedSecond = true
  			# TILE 6
  			elsif (mouse_x >= 0 and mouse_x <= 250) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 5) and (!@game_board.is_matched(5)) then
  				@game_board.flip_tile(5, true)
  				@picked2 = 5
  				@pickedSecond = true
  			# TILE 7
  			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 6) and (!@game_board.is_matched(6)) then
  				@game_board.flip_tile(6, true)
  				@picked2 = 6
  				@pickedSecond = true
  			# TILE 8
  			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 7) and (!@game_board.is_matched(7)) then
  				@game_board.flip_tile(7, true)
  				@picked2 = 7
  				@pickedSecond = true
  			# TILE 9
  			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 8) and (!@game_board.is_matched(8)) then
  				@game_board.flip_tile(8, true)
  				@picked2 = 8
  				@pickedSecond = true
  			# TILE 10
  			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 9) and (!@game_board.is_matched(9)) then
  				@game_board.flip_tile(9, true)
  				@picked2 = 9
  				@pickedSecond = true
  			end
			sleep(0.2) # needs delay because gosu's mouse click event seems to be hyper sensitive and picks up multiple clicks instead of 1
  		end
  	end
  end
  
  ## the check_match function will be called after the the frameCounter has reached a certain point. 
  # this function will check if the two tiles that have been selected match. it will compare the strings that determine each
  # tile's id. if the strings are the same then the two tiles match; the strings are the path to that tile's main image.
  # if the strings do not match then the tiles are flipped over and the game is set back to phase 0.
  def check_match
  	if @phase == 1 and @pickedSecond == true
  		# check if they match
  		if(@game_board.get_id(@picked) == @game_board.get_id(@picked2))
  			@game_board.matchTile(@picked)
  			@game_board.matchTile(@picked2)
        
        # increment match counter
        @game_board.inc_match
  		else
  			# flip the tiles 
  			@game_board.flip_tile(@picked, false)
  			@game_board.flip_tile(@picked2, false)
  		end
  		@pickedSecond = false
  		@phase = 0
  	end
  end
  
  ## this function specifies that the cursor should be displayed when it is inside the main gosu window
  def needs_cursor?
  	true
  end
  
  ## function that will be used to draw a blue background with a slight gradient towards the bottom
  def draw_background
      draw_quad( 0, 0, TOP_COLOR,
                 @width, 0, TOP_COLOR,
                 0, @height, BOTTOM_COLOR,
                 @width, @height, BOTTOM_COLOR,
                 -1 )
  end
   
  ## function that draws the background and winning font when the user wins the game 
  def draw_win
    draw_quad( 0, 0, WTOP_COLOR,
               @width, 0, WTOP_COLOR,
               0, @height, WBOTTOM_COLOR,
               @width, @height, WBOTTOM_COLOR,
               -1 )
    @endFont.draw("You win!", @width/2 - 150, @height/2, 0, 4, 4, 0xFFFFFFFF)
  end
  
  ## function that draws the background and losing font when the users loses the game
  def draw_lose
    draw_quad( 0, 0, LTOP_COLOR,
               @width, 0, LTOP_COLOR,
               0, @height, LBOTTOM_COLOR,
               @width, @height, LBOTTOM_COLOR,
               -1 )
    @endFont.draw("You lose...", @width/2 - 150, @height/2, 0, 4, 4, 0xFFFFFFFF)
  end
  
  ## this function is called at the end of the display period for images. since pictures display for a few seconds before flipping over again,
  # this function will allow the user to win if they flip over the last pair when the time left is less than the display period.
  def check_win
    if @game_board.return_count == 5 and @timer.return_time >= 0
      @win = true
    end
    if @game_board.return_count < 5 and @timer.return_time == 0
      @lose = true
    end
  end
end