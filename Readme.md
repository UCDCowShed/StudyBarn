# ECS 189E - StudyBarn

##### Name: Yeongjin Lee
##### Student ID: 916567611
##### Name: Ann Yip
##### Student ID: 919530072
##### Name: Jinho Yon
##### Student ID: 917507227

## Summary of Project
Our app “StudyBarn” helps students easily locate and explore study environments on campus, providing information on 
campus resources in each area. Features include filtering/searching for resources, recommendations, and saving favorite
area, allowing newcomers to the campus an optimal study experience.

## Overview of the Code
### Structure of the App
There are 3 main views that the user can navigate to, ExploreView, MapView, and ProfileView, through the SelectView bar on the bottom of the screen.

### ExploreView
The ExploreView includes a FilterBar on top and a ScrollView of a list of places. When tapped on the FilterBar, it navigates to a FilterView, whose information is shared with the MapView's FilterBar. Each area listed on the ScrollView navigates to a DetailsView for the area. 

Inside the DetailsView, more information about the area is listed as well as the subareas associated with it. Users can interact with the subareas by favoriting them. Then an API request will be sent to the server to add that area to the list of favorite areas to be displayed on ProfileView.

### MapView


### ProfileView


## Models
### User 
The UserModel contains these variables: userId, email, name, photoUrl, dateCreated, and favorites. The photoUrl comes from the Google profile image after the user logs in with the Google account. The favorites contain the subarea ids that the user liked.

### Area
The AreaModel consists of these variables: areaId, name, rating, images, openHour, closeHour, latitude, longitude, outdoors, indoors, groupStudy, quietStudy, microwave, printer, dining, outlets, computers, and visited.

- The rating will be set to 0 by default. The app does not have a rating system yet but once the rating system feature gets added, rating value will be used.
- The image value is the paths to the images stored in the firebase Firestore.
- Outdoors, indoors, groupStudy, quietStudy, microwave, printer, dining, outlets, and computers are the boolean values that default to be false.
- The visited value gets updated when the user enters the area. It is the ***total*** visited people. Once the app gets more users, these values will be used to provide approximate busyness/crowdedness of the area.

### SubArea
The SubAreaModel consists of these variables: subAreaId, name, areaId, floor, images, outdoors, groupStudy, microwave, printer, dining, outlets, computers, bougie, lecture, independent, bustling, grassy, and rating.

- The AreaId is the area that the subarea is associated with.
- These features - bougie, lecture, independent, bustling, and grassy - are determined by us to use for the personalized study spot recommendation system in the future.
- The rating value will be used after we implement the rating system.

## How to Fix Common Errors
1) If "No Account for Team "XXXXXXXXX". Add a new account in Accounts settings or verify that your accounts have valid credentials." and "No profiles for 'ucdavis.cs.ecs189e.StudyBarn' were found: Xcode couldn't find any iOS App Development provisioning profiles matching 'ucdavis.cs.ecs189e.StudyBarn'." errors show up, please set it to your own ***Team*** and ***Bundle Identifier***.
2) If you find "Package.resolved file is corrupted or malformed" or "XXXX library/package not found/unresolved" errors, do the following steps:
- 1) Run this in your terminal
```
cd StudyBarn.xcodeproj/project.xcworkspace/xcshareddata/swiftpm
rm Package.resolved
```
- 2) Rebuild the app.

## How to Test User Location Tracking
1) Run the app
2) If you are already logged in, please log out and log in again.
3) Navigate to the map view and allow tracking.
4) Set your Simulator location to the longitude and latitude of the study spots we have.
5) Go to explore view and refresh (drag the screen downwards as the common apps do to refresh).
6) Check if the ***visited*** value increased for that area. If the value did not increase, log out and log in again and do the same process from 3 - 5.
7) If you refresh again at this point, you will notice that the visited value does not increase since there were no changes in your location.
8) Change your location to some other longitude and latitude and change back to the study spot's longitude and latitude.
9) Refresh in the explore view, and you will see the visited value increased for that area.
