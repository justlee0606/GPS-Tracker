# GPS Tracker

GPS Tracker is an IOT mobile application that allows the user to keep track of where their personal belongings are at all times. 

## Description

This iOS app that uses Firebase as the backend has a user login system, and stores all of the users's GPS trackers on the online database. These trackers can be given
nicknames and are displayed on a map that also shows the user's current location. 

## Screenshots
[![Simulator-Screen-Shot-i-Phone-11-Pro-2020-09-23-at-14-06-26.png](https://i.postimg.cc/RhVyYpng/Simulator-Screen-Shot-i-Phone-11-Pro-2020-09-23-at-14-06-26.png)](https://postimg.cc/N9Sd94DX) [![Simulator-Screen-Shot-i-Phone-11-Pro-2020-09-23-at-14-07-12.png](https://i.postimg.cc/j5RFW3vR/Simulator-Screen-Shot-i-Phone-11-Pro-2020-09-23-at-14-07-12.png)](https://postimg.cc/Z9Dc2c1Q)

See in realtime where your belongings are, and also add and delete location trackers from the app.

## Installation and Setup Instructions
Clone this repository. You will need to setup a Firebase project, and add the GoogleService-Info.plist file to the project.

## Reflection
This was a week long side project that includes an Arduino code portion to pair the location tracker with the app (See GPS-Tracker-Arduino). The goal of this
project was to achieve and easy and simple way to be able to keep track of where your personal belongings are. This solution uses an ESP8266 which enables the GPS
coordinates to be sent via WiFi, but in the future, I plan to transition to a solution that utilizes a LoRa (Low power, wide area) network to transmit the data. This would allow each 
device tracker to work without the need of WiFi or cellular connection, and the coverage would therefore be much wider. The applications for LoRa technology paired
with GPS tracking are endless, as you can not only track personal belongings, but also other things that may not have access to the Internet, such as seniors, 
children, and pets.
