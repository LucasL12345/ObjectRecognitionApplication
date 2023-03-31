
# Object Recognition App


## General App Information

This is my swift application for my level 4 individual project. This project details the creation of an app for blind or visually impaired users, that uses object recognition to help them find specific objects and understand their environment better. The app's main aims were to be highly usable to its target users, and provide a user friendly experience. It features a main view to scan the environment for objects using the devices rear camera and detect objects, as well as a settings page to customize the user experience and app information page to describe how the app works and its layout. Finally, there is a choose items page where users can select specific items for the app to search for in the main view. 

## App Description

On the main opening page, there are three buttons. Firstly, a large button at the bottom with two modes - finding all objects and finding selected objects. Finding all objects mode will read out any objects the app can detect through the device's camera, and finding selected objects mode will only read out any objects found that are selected in the Choose Items page. To get to this page you can press the button at the top right of the screen. In this page, there is a list of objects that you can select, and then press either the Confirm button at the bottom or the Back button at the top left to go back to the main page. The only difference is that the Confirm button will read out your selected objects whereas the back button wont. Finally, on the main page, there is a Settings button at the top left. From this page you can turn the vibration on or off for either 'finding' mode, turn dark mode on or off, and go to the app information page (this page). Every page except the main page, have large back buttons located in the top left, and a text resizing option located in the top right.


## Installation

In order to install the app, you must be running macOS. Start by cloning or downloading the repo and open the project using XCode. Next, you need to download the YOLOv3 object recognition model from - https://developer.apple.com/machine-learning/models/. After doing so, drag this into the project navigation tab. Ensure that the model name and the model read in the VisionObjectRecognitionViewController are the same. After this, you should be able to simply run the project. Note that you may need to change the bundle identifier in the signing in & capabilities tab if this throws an error, as for all downloaded XCode projects. The app also requires the use of the devices camera and as such will require an apple device with one to be used to run and test the app. Finally, you can run the test suite by running using command + U.

## Support

Feel free to contact me any time for support regarding any aspects of the project.
Email: 2457626L@student.gla.ac.uk

## Roadmap

Future releases could potentially incorporate the following:
- use of Siri commands to perform functions
- dark mode to be fixed (this feature is currently just a prototype for the settings page)
- use of LiDAR for obstacle detection
- objects inclusive of outdoors 
- option to enable or disable voice feedback in settings


## Contributing

Unfortunately I will not be continuing this project and I am not open to contributions. 


## License

This project is open source and individuals are free to use it.


## Project status

The development for this project has stopped and likely will not be continued in future, as it was developed for my 4th year project and I have no current desire to continue it. 
