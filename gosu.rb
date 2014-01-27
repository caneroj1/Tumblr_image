require 'gosu'
require 'open-uri'
require_relative 'tumblr.rb'
require_relative 'board.rb'
require_relative 'tile.rb'

class MyWindow < Gosu::Window

  def initialize
   
   #initialize the window and caption it
   super(1920, 1080, false) 
   self.caption = 'Tumblr Image Match!'
   
   #array of image names that will be opened
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
	
   #create a pseudorandom number generator for shuffling
   prng = Random.new(Random.new_seed())
   
   #Durstenfield's Shuffling Algorithm 
   for i in(9).downto(1)
	j = prng.rand(i)
	temp = @imgNames[i]
	@imgNames[i] = @imgNames[j]
	@imgNames[j] = temp
   end
	
   #create the Gosu images so they can be put in to each Tile object
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
   
   #initialize the game board with the tile objects
   @game_board = Board.new( Tile.new(img1, 0, 0, img0), 
   							Tile.new(img2, 250, 0, img0), 
   							Tile.new(img3, 500, 0, img0), 
   							Tile.new(img4, 750, 0, img0), 
   							Tile.new(img5, 1000, 0, img0), 
   							Tile.new(img6, 0, 500, img0), 
   							Tile.new(img7, 250, 500, img0), 
   							Tile.new(img8, 500, 500, img0), 
   							Tile.new(img9, 750, 500, img0), 
   							Tile.new(img10, 1000, 500, img0) )
  end
  
  def update
  	if button_down? Gosu::MsLeft then
  		puts mouse_x
  		File.delete(@imgNames[1])
  		window.close
  	end
  end
  
  def draw
  	@game_board.draw_board
  end
  
  def needs_cursor?
  	true
  end
end

window = MyWindow.new
window.show