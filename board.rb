require_relative 'tile.rb'

class Board
	
	## initialize function of the board class: this will accept 10 parameters that are each a path to an image
	# it will then populate the tile array appropriately with each image
	def initialize(t1, t2, t3, t4, t5, t6, t7, t8, t9, t10)
		@tile_Array = Array.new(10)
		@tile_Array[0] = t1
		@tile_Array[1] = t2
		@tile_Array[2] = t3
		@tile_Array[3] = t4
		@tile_Array[4] = t5
		@tile_Array[5] = t6
		@tile_Array[6] = t7
		@tile_Array[7] = t8
		@tile_Array[8] = t9
		@tile_Array[9] = t10
	end
	
	# draw function of the board class: this will go through the tile array and draw each tile
	def draw_board
		for i in 0..9
			@tile_Array[i].draw
		end
	end
	
	# this function will flip a given tile to the face indicated by the parameter bool. false = facedown, true = face up
	def flip_tile(ind, bool)
		@tile_Array[ind].flip(bool)
	end

	# this function will get the id from the desired tile
	def get_id(ind)
		return @tile_Array[ind].return_id
	end
	
	# this function will set a tile to its "matched" configuration
	def matchTile(ind)
		@tile_Array[ind].set_match
	end
	
	# this function will get the matched status of a specific tile and return it
	def is_matched(ind)
		return @tile_Array[ind].return_match
	end
end