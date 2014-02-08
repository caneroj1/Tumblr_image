<h1>Tumblr Image Matcher</h1>

<p>This is the repository for a game I am making that will utilize the Tumblr api.</p>

<p>I am pulling images from the Tumblr api and they will be used to make an image matching game.</p>

<h2>This game is now a gem</h2>

<p>I have made this into a gem and published it to RubyGems.org</p>
<p>The gem is available at the following link: <a href="https://rubygems.org/gems/tumblr-game">tumblr-game</a></p>

<strong>The gems I am using in this project so far are:</strong>
<ul>
    <li>tumblr_client, 0.8.2</li>
    <li>multipart-post, 1.2.0</li>
    <li>gosu, 0.7.50</li>
	<li>faraday, 0.8.9</li>
</ul>

<p>The game pulls 5 images from a Tumblr blog of the user's choice and sets up a game board with them. Each picture has a generic background (tumblr.png) and is flipped over then the user clicks on the picture. When the card is flipped over, its true image is displayed. The user then is allowed to pick another image. If the image selected next matches the previous one, the two images are replaced with a check mark indicating they have been matched (check.png). If the images do not match, the user is shown the images for a brief period before they are flipped over again. There is currently a timer implemented and it is set for 30 seconds.</p>

<p>If the timer runs out and the user has not matched all of the images, the game is over and a losing screen is displayed. If user matches all of the images, then the winning screen is displayed.</p>

<p>The images that the game downloads from Tumblr are processed and stored on the user's desktop. When the user closes the game window, either prematurely, after losing, or after winning, all of the pictures are deleted from the desktop.</p>

<h3>Things to implement:</h3>
<ul>
	<li><em>DONE</em>Add a game completion state for when the user matches all of the images.</li>
	<li><em>DONE</em>Add a game failure state for when the user fails to match all of the images in the allotted time.</li>
	<li>Fix the way images are being handled. Currently each of the 5 images are being copied to make another image file. This should be changed to just use the 5 images over again.</li>
</ul>
