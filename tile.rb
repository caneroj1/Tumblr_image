require 'gosu'

class Tile
	
	## initialize function of the Tile class: this will create a Tile object with all necessary parameters
	# Parameters: image name, xLocation, and yLocation. image name is the name of the image that was saved, and the location variables
	# give the Tile's location on the board
	# img2 will be used as the back of the image for when it is face-down
	# idStr is the string that contains the path of the image for the given tile, it will be used for comparisons between tiles
	def initialize( img, xL, yL, img2, idS )
		@image = img
		@rev = img2
		@xLocation = xL
		@yLocation = yL
		@flipped = false
		@idStr = idS
	end
	
	# draw function of the Tile class: this will draw the image at the Tile's specified location
	def draw
		if !@flipped then
			@rev.draw(@xLocation, @yLocation, 0)
		else
			@image.draw(@xLocation, @yLocation, 0)
		end
	end
	
	# flip function of the Tile class: this will make the Tile be drawn with its true image
	def flip( bool )
		@flipped = bool
	end
	
	# return_id function of the Tile class: this will return the given Tile's id to be used in comparisons
	def return_id
		return @idStr
	end
end