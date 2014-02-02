<h1>Tumblr Image Matcher</h1>

<p>This is the repository for a game I am making that will utilize the Tumblr api.</p>

<p>I am pulling images from the Tumblr api and they will be used to make an image matching game.</p>

<h2>The gems I am using in this project so far are:</h2>
<ul>
    <li>tumblr_client</li>
    <li>open-uri</li>
    <li>gosu</li>
	<li>faraday</li>
</ul>

<p>The game pulls 5 images from a Tumblr blog of the user's choice and sets up a game board with them. Each picture has a generic background (tumblr.png) and is flipped over then the user clicks on the picture. When the card is flipped over, its true image is displayed. The user then is allowed to pick another image. If the image selected next matches the previous one, the two images are replaced with a check mark indicating they have been matched (check.png). If the images do not match, the user is shown the images for a brief period before they are flipped over again. There is currently a timer implemented and it is set for two minutes.</p>

<h3>Things to implement:</h3>
<ul>
	<li>Add a game completion state for when the user matches all of the images.</li>
	<li>Add a game failure state for when the user fails to match all of the images in the allotted time.</li>
	<li>Fix the way images are being handled. Currently each of the 5 images are being copied to make another image file. This should be changed to just use the 5 images over again.</li>
</ul>
