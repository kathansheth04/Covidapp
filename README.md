# Covidapp

Covidapp is the ultimate survival kit during the coronavirus pandemic. As a native app supported in iOS and Android, it can let users add, downvote, and remove supplies that they see in stores. Since the apis for supplies in the stores were unavailable, we made this app a public-based app so the users can make the changes. For security purposes, we added a downvote system so that if an item has more than 4 downvotes, it will be removed from the list (since it would not be available), and if the item is recently put by the users, it will show up first on the supplies screen. Furthermore, we also added a way to tell the users the closest covid-19 testing sites so that they can get themselves tested for it. They can use their current location simply by turning the location on their mobile device on, and if they do not want to show their current location, they can change their address in the settings page.

# Features

* Email and/or Google Signin for authentication 
* Geolocator used to find the closest Testing site available near the user
* Firebase Realtime Database used to store list of supplies, make changes of list, and track downvotes so that items with more than 4 downvotes are removed. 

# Video Demonstration of the App



# Development Environment and softwares Used

* [Flutter with Dart](https://flutter.dev/)
* [Testing sites in California Api](https://covid-19-testing.github.io/locations/california/complete.json) from Postman
* [Firebase for authentication and storing information in Realtime Database](https://firebase.google.com/)
* [Figma to sktech app UI](https://www.figma.com/)

# Packages Used for Flutter

* [HTTP](https://pub.dev/packages/http)
* [Google Sign in](https://pub.dev/packages/google_sign_in)
* [Firebase Auth](https://pub.dev/packages/firebase_auth)
* [Provider](https://pub.dev/packages/provider)
* [Geolocator](https://pub.dev/packages/geolocator)
* [Url Launcher](https://pub.dev/packages/url_launcher)

# Team

* Kathan Sheth (sheth.kathan@gmail.com)
* Anirudh Balaji (anire.balaji@gmail.com)
* Sashv Dave (davesashv@gmail.com)
* Chenghao li (chenghaoli36@gmail.com)
