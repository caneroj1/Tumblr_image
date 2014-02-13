Gem::Specification.new do |s|
  s.name        = 'tumblr-game'
  s.version     = '2.0.3'
  s.add_runtime_dependency "faraday", ["=0.8.9"]
  s.add_runtime_dependency "gosu", ["0.7.50"]
  s.add_runtime_dependency "multipart-post", ["1.2.0"]
  s.add_runtime_dependency "tumblr_client", ["0.8.2"]
  s.executables << 'Main'
  s.date        = '2014-02-04'
  s.summary     = "Tumblr Image Matching game!"
  s.description = "A simple game that allows users to download images from Tumblr blogs and use them for an image matching game."
  s.authors     = ["Joe Canero"]
  s.email       = 'caneroj1@tcnj.edu'
  s.files       = ["lib/tumblr-game.rb", 
                  "lib/tumblr-game/tumblr.rb", 
                  "lib/tumblr-game/gosu.rb", 
                  "lib/tumblr-game/tile.rb", 
                  "lib/tumblr-game/board.rb", 
                  "lib/tumblr-game/timer.rb",
                  "resources/check.png",
                  "resources/tumblr.png"]
  s.homepage    =
    'https://github.com/caneroj1/Tumblr_image'
  s.license       = 'MIT'
end
