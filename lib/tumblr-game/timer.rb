require 'gosu'

## TIMER CLASS. This class handles the timing aspect of the game. The initialize function accepts parameters that pass in a font, the timer location,
# and the amount of time the game will run for. The update function will increment the frame counter by 1 every frame until it gets to 60. It then resets
# to zero. The draw function renders the Timer on the game screen at the location established in initialize. The return_time function returns the time
# left in the game.

class Timer
  
  ## initialize function of the timer class
  # this will create a Timer object with parameters
  # fontParam = a Gosu font object 
  # pX = the x coordinate of where the font will display
  # pY = the y coordinate of where the font will display
  # the timer object also maintains a frame count and a count of the total time
  def initialize(fontParam, pX, pY, time)
    @font = fontParam
    @frameCounter = 0
    @totalTime = time
    @posX = pX
    @posY = pY
  end
  
  ## the update function of the timer class does most of the timing job
  # the frame counter variable is updated every 16.666666 ms (Gosu's default refresh rate)
  # this leads to about 60 frames per second, so every 60 frames the total time count will decrease by 1
  def update
    if @frameCounter < 60 then
      @frameCounter += 1
    else
      @frameCounter = 0
      if @totalTime != 0 then
        @totalTime -= 1
      end
    end
  end
  
  ## the draw function of the timer utilizes the draw function of the font object that was passed in
  # it will draw the font object with text being the time remaining at location (posX, posY) in the window
  def draw
    @font.draw("Time: #{@totalTime}", @posX - 100, @posY, 0, 2, 2, 0xFFFFFFFF)
  end
  
  ## the return time function of this class will return the time that is remaining in the game
  def return_time
    return @totalTime
  end
  
end