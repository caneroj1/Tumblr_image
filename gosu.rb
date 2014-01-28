require 'gosu'
require 'open-uri'
require_relative 'tumblr.rb'
require_relative 'board.rb'
require_relative 'tile.rb'

class MyWindow < Gosu::Window

  def initialize
   ## define a variable that indicates what state the game is in
   # when phase = 0, that indicates that the user is in the "picking" stage of the game and is selecting a face down card for an
   # initial guess
   # when phase = 1, that indicates that the user is in the "matching" stage of the game and is selecting another card to see if it
   # matches the previous one. after the user clicks the mouse, the images will be shown and then they will be left face up if they match,
   # otherwise both cards will go back to facedown. phase is always set to 0 after this stage.
   @phase = 0
   @frameCounter = 0
   
   # define two variables that indicates the first card that was selected when phase was 0 and the second card selected when 
   # phase = 1
   @picked = 0
   @picked2 = 0
   
   # variable that indicates the second card was picked
   @pickedSecond = false
   
   # initialize the window and caption it
   super(1920, 1080, false) 
   self.caption = 'Tumblr Image Match!'
   
   # array of image names that will be opened
   @imgNames = [
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
	
   # create a pseudorandom number generator for shuffling
   prng = Random.new(Random.new_seed())
   
   # Durstenfield's Shuffling Algorithm 
   for i in(9).downto(1)
	j = prng.rand(i)
	temp = @imgNames[i]
	@imgNames[i] = @imgNames[j]
	@imgNames[j] = temp
   end
	
   # create the Gosu images so they can be put in to each Tile object
   img0 = Gosu::Image.new(self, "tumblr.png", true)
   img1 = Gosu::Image.new(self, @imgNames[0], true)
   img2 = Gosu::Image.new(self, @imgNames[1], true)
   img3 = Gosu::Image.new(self, @imgNames[2], true)
   img4 = Gosu::Image.new(self, @imgNames[3], true)
   img5 = Gosu::Image.new(self, @imgNames[4], true)
   img6 = Gosu::Image.new(self, @imgNames[5], true)
   img7 = Gosu::Image.new(self, @imgNames[6], true)
   img8 = Gosu::Image.new(self, @imgNames[7], true)
   img9 = Gosu::Image.new(self, @imgNames[8], true)
   img10 = Gosu::Image.new(self, @imgNames[9], true)
   
   # initialize the game board with the tile objects
   @game_board = Board.new( Tile.new(img1, 0, 0, img0, @imgNames[0]), 
   							Tile.new(img2, 250, 0, img0, @imgNames[1]), 
   							Tile.new(img3, 500, 0, img0, @imgNames[2]), 
   							Tile.new(img4, 750, 0, img0, @imgNames[3]), 
   							Tile.new(img5, 1000, 0, img0, @imgNames[4]), 
   							Tile.new(img6, 0, 500, img0, @imgNames[5]), 
   							Tile.new(img7, 250, 500, img0, @imgNames[6]), 
   							Tile.new(img8, 500, 500, img0, @imgNames[7]), 
   							Tile.new(img9, 750, 500, img0, @imgNames[8]), 
   							Tile.new(img10, 1000, 500, img0, @imgNames[9]) )
  end
  
  # update function. this function contains all of the game logic
  def update
  	## only allow the user to pick tiles if the frameCounter is at 0
  	# this means that the user can only pick tiles when two tiles are not being displayed
  	# after the 96 frames of display are over, we then call the check_match function and set the frameCounter back to 0 
    if @frameCounter == 0 then 
  		pick_tiles	
  	elsif @frameCounter == 96 then
  		check_match
  	 	@frameCounter = 0
  	end
  	
  	# if the user has picked their second tile then we increment the frame counter to display both of them for a few seconds
  	if @phase == 1 and @pickedSecond then
  	 @frameCounter += 1
  	end
  end
  
  # draw function. this one calls the game_board object and tells it to draw all of the tiles
  def draw
  	@game_board.draw_board
  end
  
  ## pick_tiles function
  # this function has two parts. if the game is in phase 0, the user is picking an initial tile. the function will check the location
  # of the user's mouse and flip the appropriate tile and keep track of which tile was flipped. then, the game is set to phase 1.
  # in phase 1, the user is picking the tile they want to match with the first one. if a tile is successfully picked, the pickedSecond
  # variable is set to true and the game stores which tile was picked and flipped.
  def pick_tiles
  	if @phase == 0 
		if button_down? Gosu::MsLeft then
			# TILE 1
			if (mouse_x >= 0 and mouse_x <= 250) and (mouse_y >= 0 and mouse_y <= 250) then
				@game_board.flip_tile(0, true)
				@picked = 0
				@phase = 1
			# TILE 2
			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y >= 0 and mouse_y <= 250) then
				@game_board.flip_tile(1, true)
				@picked = 1
				@phase = 1
			# TILE 3
			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y >= 0 and mouse_y <= 250) then
				@game_board.flip_tile(2, true)
				@picked = 2
				@phase = 1
			# TILE 4
			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y >= 0 and mouse_y <= 250) then
				@game_board.flip_tile(3, true)
				@picked = 3
				@phase = 1
			# TILE 5
			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y >= 0 and mouse_y <= 250) then
				@game_board.flip_tile(4, true)
				@picked = 4
				@phase = 1
			# TILE 6
			elsif (mouse_x >= 0 and mouse_x <= 250) and (mouse_y > 500 and mouse_y <= 750) then
				@game_board.flip_tile(5, true)
				@picked = 5
				@phase = 1
			# TILE 7
			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y > 500 and mouse_y <= 750) then
				@game_board.flip_tile(6, true)
				@picked = 6
				@phase = 1
			# TILE 8
			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y > 500 and mouse_y <= 750) then
				@game_board.flip_tile(7, true)
				@picked = 7
				@phase = 1
			# TILE 9
			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y > 500 and mouse_y <= 750) then
				@game_board.flip_tile(8, true)
				@picked = 8
				@phase = 1
			# TILE 10
			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y > 500 and mouse_y <= 750) then
				@game_board.flip_tile(9, true)
				@picked = 9
				@phase = 1
			end
			sleep(0.2) # needs delay because gosu's mouse click event seems to be hyper sensitive and picks up multiple clicks instead of 1
  		end
  	else @phase == 1
  		if button_down? Gosu::MsLeft then
  			# TILE 1
			if (mouse_x >= 0 and mouse_x <= 250) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 0) then
				@game_board.flip_tile(0, true)
				@picked2 = 0
				@pickedSecond = true
			# TILE 2
			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 1) then
				@game_board.flip_tile(1, true)
				@picked2 = 1
				@pickedSecond = true
			# TILE 3
			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 2) then
				@game_board.flip_tile(2, true)
				@picked2 = 2
				@pickedSecond = true
			# TILE 4
			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 3) then
				@game_board.flip_tile(3, true)
				@picked2 = 3
				@pickedSecond = true
			# TILE 5
			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y >= 0 and mouse_y <= 250) and (@picked != 4) then
				@game_board.flip_tile(4, true)
				@picked2 = 4
				@pickedSecond = true
			# TILE 6
			elsif (mouse_x >= 0 and mouse_x <= 250) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 5) then
				@game_board.flip_tile(5, true)
				@picked2 = 5
				@pickedSecond = true
			# TILE 7
			elsif (mouse_x > 250  and mouse_x <= 500) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 6) then
				@game_board.flip_tile(6, true)
				@picked2 = 6
				@pickedSecond = true
			# TILE 8
			elsif (mouse_x > 500  and mouse_x <= 750) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 7) then
				@game_board.flip_tile(7, true)
				@picked2 = 7
				@pickedSecond = true
			# TILE 9
			elsif (mouse_x > 750  and mouse_x <= 1000) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 8) then
				@game_board.flip_tile(8, true)
				@picked2 = 8
				@pickedSecond = true
			# TILE 10
			elsif (mouse_x > 1000  and mouse_x <= 1250) and (mouse_y > 500 and mouse_y <= 750) and (@picked != 9) then
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
  		#check if they match
  		if(@game_board.get_id(@picked) == @game_board.get_id(@picked2))
  			#match!
  			
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
end

window = MyWindow.new
window.show