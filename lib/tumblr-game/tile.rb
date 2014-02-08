require 'gosu'

## TILE CLASS. This class represents each of the pictures in the game window. Each tile is created with the initialize function that accepts a Gosu
# image for the main picture (img), x- and y-coordinates, an image to display when the tile is face down (img2), and id string, and a completion image
# that is displayed when the tile is matched (chkImg). The draw function renders the tile to the game window. This class contains various utility
# functions for tiles.

class Tile
	
	## initialize function of the Tile class: this will create a Tile object with all necessary parameters
	# Parameters: image name, xLocation, and yLocation. image name is the name of the image that was saved, and the location variables
	# give the Tile's location on the board
	# img2 will be used as the back of the image for when it is face-down
	# idStr is the string that contains the path of the image for the given tile, it will be used for comparisons between tiles
	def initialize( img, xL, yL, img2, idS, chkImg )
		@image = img
		@rev = img2
		@xLocation = xL
		@yLocation = yL
		@flipped = false
		@matched = false
		@idStr = idS
		@chkImage = chkImg
	end
	
	## draw function of the Tile class: this will draw the image at the Tile's specified location.
  # if the tile is not fliped and not matched, then its facedown image is drawn.
  # if the tile is flipped and not matched, then its true image is drawn.
  # if the tile is matched, then the completion image is drawn.
	def draw
		if !@flipped and !@matched then
			@rev.draw(@xLocation, @yLocation, 0)
		elsif @flipped and !@matched
			@image.draw(@xLocation, @yLocation, 0)
		else
			@chkImage.draw(@xLocation, @yLocation, 0)
		end
	end
	
	## flip function of the Tile class: this will make the Tile be drawn with its true image
	def flip( bool )
		@flipped = bool
	end
	
	## return_id function of the Tile class: this will return the given Tile's id to be used in comparisons
	def return_id
		return @idStr
	end
	
	## sets the matched attribute of a Tile object to true. this will result in the tile displaying a checkmark for completion
	def set_match
		@matched = true
	end
	
	## this function will return a tile's matched status
	def return_match
		return @matched
	end
end