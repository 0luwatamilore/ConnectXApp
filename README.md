
# Project - *ConnectXApp*

**ConnectXApp** is an iOS app designed to foster a collaborative learning environment for college students, allowing them to create, share, and engage with posts in various communities. The app uses Firebase Authentication for user management and Firebase Firestore for data storage.



## User Stories

The following required functionality is completed:

* [ ] User can sign up and log in to ConnectXApp.
* [ ] User can view posts from different communities.
* [ ] User can see the username and content for each post.
* [ ] User can log out by tapping a logout button.
* [ ] User can create a new post.
* [ ] User is taken back to the feed view with the new post visible in the timeline.
* [ ] User data, including posts, is stored and retrieved from Firebase Firestore.

The following **optional** features are implemented:

* [ ] User can see the relative timestamp for each post (e.g., "5m", "1h").
* [ ] User can view their profile with additional information.
* [ ] User can like or comment on a post.
* [ ] User can reply to other users’ comments.
* [ ] User can upload a profile picture, which is displayed on posts.
* [ ] User can create a post with additional media (e.g., images).
* [ ] The app displays an activity indicator while loading data from Firebase.
* [ ] Implement "Pull to Refresh" to reload posts in the timeline.
* [ ] User sees a character counter when typing content for a new post.
* [ ] User can use custom themes and colors in the app.

## Video Walkthrough

Here's a walkthrough of implemented user stories:
<!-- Include a link to a walkthrough video or GIF demonstrating the app's functionality -->

## Open-source libraries used

* Firebase Authentication - For managing user authentication.
* Fixrebase Firestore - For storing and retrieving user and post data.
* SwiftUI - For creating the UI components in a declarative way.







## User Stories

The following **required** functionality is completed:

* [ x ] User can **sign in to Twitter** using OAuth login
* [ x ] User can **view tweets from their home timeline**
  * [ x ] User is displayed the username, name, and body for each tweet
  * [ x ] User is displayed the [relative timestamp](https://gist.github.com/nesquena/f786232f5ef72f6e10a7) for each tweet "8m", "7h"
* [ ] User can ***log out of the application** by tapping on a logout button
* [ x ] User can **compose and post a new tweet**
  * [ x ] User can click a “Compose” icon in the Action Bar on the top right
  * [ x ] User can then enter a new tweet and post this to Twitter
  * [ x ] User is taken back to home timeline with **new tweet visible** in timeline
  * [ x ] Newly created tweet should be manually inserted into the timeline and not rely on a full refresh
* [ ] User can **see a counter that displays the total number of characters remaining for tweet** that also updates the count as the user types input on the Compose tweet page
* [ ] User can **pull down to refresh tweets timeline**
* [ ] User can **see embedded image media within a tweet** on list or detail view.

The following **optional** features are implemented:

* [ ] User is using **"Twitter branded" colors and styles**
* [ ] User sees an **indeterminate progress indicator** when any background or network task is happening
* [ ] User can **select "reply" from home timeline to respond to a tweet**
  * [ ] User that wrote the original tweet is **automatically "@" replied in compose**
* [ ] User can tap a tweet to **open a detailed tweet view**
  * [ ] User can **take favorite (and unfavorite) or retweet** actions on a tweet
* [ ] User can view more tweets as they scroll with infinite pagination
* [ ] Compose tweet functionality is built using modal overlay
* [ ] User can **click a link within a tweet body** on tweet details view. The click will launch the web browser with relevant page opened.
* [ ] Replace all icon drawables and other static image assets with [vector drawables](http://guides.codepath.org/android/Drawables#vector-drawables) where appropriate.
* [ ] User can view following / followers list through any profile they view.
* [ ] Use the View Binding library to reduce view boilerplate.
* [ ] On the Twitter timeline, apply scrolling effects such as [hiding/showing the toolbar](http://guides.codepath.org/android/Using-the-App-ToolBar#reacting-to-scroll) by implementing [CoordinatorLayout](http://guides.codepath.org/android/Handling-Scrolls-with-CoordinatorLayout#responding-to-scroll-events).
* [ ] User can **open the twitter app offline and see last loaded tweets**. Persisted in SQLite tweets are refreshed on every application launch. While "live data" is displayed when app can get it from Twitter API, it is also saved for use in offline mode.

The following **additional** features are implemented:

* [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [Kap](https://getkap.co/).

## Notes

Describe any challenges encountered while building the app.

## Open-source libraries used

Firebase Authentication - For managing user authentication.
Firebase Firestore - For storing and retrieving user and post data.
SwiftUI - For creating the UI components in a declarative way.

* [Android Async HTTP](https://github.com/loopj/android-async-http) - Simple asynchronous HTTP requests with JSON parsing
* [Glide](https://github.com/bumptech/glide) - Image loading and caching library for Android

