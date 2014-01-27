require 'gosu'

class Tile
	
	#initialize function of the Tile class: this will create a Tile object with all necessary parameters
	#Parameters: image name, xLocation, and yLocation. image name is the name of the image that was saved, and the location variables
	#give the Tile's location on the board
	#img2 will be used as the back of the image for when it is face-down
	def initialize( img, xL, yL, img2 )
		@image = img
		@rev = img2
		@xLocation = xL
		@yLocation = yL
	end
	
	#draw function of the Tile class: this will draw the image at the Tile's specified location
	def draw
		@rev.draw(@xLocation, @yLocation, 0)
		#@image.draw(@xLocation, @yLocation, 0)
	end
end