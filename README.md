Tumblr_image
============

This is the repository for a game I am making that will utilize the Tumblr api.

I am pulling images from the Tumblr api and they will be used to make an image matching game.

The gems I am using in this project so far are:
    tumblr_client
    open-uri
    gosu

The Gosu gem is a Ruby graphics library, and the Tumblr Client is the gem that allows me to pull information using Tumblr's API calls.

The image matching game will pull 10 pictures from a Tumblr blog, make copies of them, and then randomize where they go in the Gosu canvas. The images will be "face down"--that is, there will be a nondescript image that is supposed to be the back of image. The user can click on each picture to reveal what is underneath. That image will still up and the user can then click on another spot to reveal that image. If the two images match, then they are removed from the canvas and the user gets some points. If they do not match, the two images are flipped over again. 

I am still deciding if there is going to be a time limit.
