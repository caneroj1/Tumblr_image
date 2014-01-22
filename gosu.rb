require 'gosu'
require 'open-uri'
require_relative 'tumblr.rb'

class MyWindow < Gosu::Window

  def initialize
   super(1920, 1080, false)
   self.caption = 'Tumblr Image Match!'
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
   @gamePics = Array.new(10)
   @background = Gosu::Image.new(self, @imgNames[1], true)
   @gamePics[0] = Gosu::Image.new(self, @imgNames[1], true)
  end
  
  def update
  	if button_down? Gosu::KbEscape then
  		File.delete(@imgNames[1])
  		window.close
  	end
  end
  
  def draw
  	@background.draw(0, 0, 0)
  	@gamePics[0].draw(250,0,0)
  end
  
  def needs_cursor?
  	true
  end
end

window = MyWindow.new
window.show