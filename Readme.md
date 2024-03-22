# ECS 189E - StudyBarn

##### Name: Yeongjin Lee
##### Student ID: 916567611
##### Name: Ann Yip
##### Student ID: 919530072
##### Name: Jinho Yon
##### Student ID: 917507227

## Summary of Project
Our app “StudyBarn” helps students easily locate and explore study environments on campus, providing information on 
campus resources in each area. Features include filtering/searching for resources, recommendation, and saving favorite
area, allowing newcomers to the campus an optimal study experience.

## Overview of the Code
### Structure of the App
There are 3 main views that the user can navigate to, ExploreView, MapView, and ProfileView, through the SelectView bar on the bottom of the screen.

### ExploreView
The ExploreView includes a FilterBar on top, and a ScrollView of list of places. When tapped on the FilterBar, it navigates to a FilterView, whose information is shared with the MapView's FilterBar. Each area listed on the ScrollView navigates to a DetailsView for the area. 

Inside the DetailsView, more information about the area is listed as well as the subAreas associated with it. User can interact with the subAreas by favoriting it. Then an API request will be sent to the server to add that area into the list of favorite areas to be displayed on ProfileView.

### MapView


### ProfileView


## Data Structure

### User

### Area

### SubArea

## How to Test User Location Tracking
