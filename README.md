#SumPoints#

This is an app I built in July 2014 while learning how to code at [Bloc](https://www.bloc.io). It took about 3 weeks to build a prototype, and there are a number of features I never got to implement, but I will hopefully come back to them in the future.

###Objective of App###

SumPoints is an app that can help a user bookmark key points from an article, video or other source on the internet.

###Basic Functions###

 * Users can sign up with email, Facebook, or Twitter.
 
 * User can add new Post (a source object with a valid URL).

 * User can add a SumPoint to any Post (SumPoints are summary points from an article, video, or other source on the internet).

 * User can like SumPoints (thereby storing them in their library).

 * User can follow Posts (allowing them to be notified by email when new SumPoints are added to a Post).

###Outstanding Issues to Fix###

 * User cannot yet delete their posts or SumPoints.

 * Duplicate records (will need a method to check for duplicate posts so same source item is not posted twice)

 * Search capability 

 * Ability to mark Posts or SumPoints as private


###App About Page###
![App Picture](http://i.imgur.com/dojFHy5.png)

### Ruby and Rails Versions ###

    #!Versions
    Ruby "2.1.2" 
    Rails '4.1.1'

###Helpful Resources###

* [Omniauth Tutorial](http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/)
