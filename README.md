GameStudio

How to Run

 1) Download the Sourcecode from https://github.com/ThinkAnts/GameStudio.git
 2) Install CocoaPods
 3) Open GamesStudio.xcworkspace in xcode and select ios simulator and run the project

CocoaPods Installation

1) Go to Project workspace and the run "pod install"
2) This will install pods used in the project

List of Pods  used in application
1) SDWebImage --> Fetching Image from URL and cacheing the image.
2) SkeletonView ---> an elegant way to show users that something is happening and also prepare them for which contents are waiting.


** MVVM design pattern is used to implement the app.
** code is organised in such that
       Models --> Skeleton of Model Objects ,  
       Network -> URL Request and Response Handler , Request and Response Model are separate so that incase changes required its easy to Handler
       Utilities --> Constants and Error Keys and other extensions if needed can be added
       View Model --> Where most of the business logic is implemented.

** Added scope of handling UnitTest cases for UI and Functional requirement.

** UIImage usually takes lot of time to load. Its required to cache UIimages so that if user goes back and forth of the same record Images are cached.

** Responsibilities related to functionalities are evenly shared between parts of code. Fatty View controller is avoided.
** Right now all the data is loaded once from the API. If loaded based on pages then Prefecth data source can be implemented in the list which improves performance.
