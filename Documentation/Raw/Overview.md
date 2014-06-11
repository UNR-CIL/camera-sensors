# GB SciCam Overview

## Summary
The GB SciCam is a Universal iOS app for iPhone and iPad. It receives its data from a REST server that provides an API layer to the archived data from the SiteProxy software.

## Architecture

### Server
The cameras in the field have their data collected by the SiteProxy software. SiteProxy also archives that data in an FTP server. The data in the FTP server is made available via an API through a REST server. The Cameras app uses that API to make structured requests to build up the data it displays.

### Library Dependencies

The Cameras uses [CocoaPods][cocoapods] for library management.


## Components

The app uses [AFNetworking][afnetworking] for its network library. The data is stored in an [NSFetchedResultsController][nsfetchedresultscontroller] and the controller sorts, indexes, and sections the data. The sectioned data is then displayed using a [UICollectionViewController][uicollectionviewcontroller] that displays the photos in a grid sectioned according to regions and sites in those regions.



[cocoapods]: http://cocoapods.org
[afnetworking]: http://cocoadocs.org/docsets/AFNetworking
[nsfetchedresultscontroller]: https://developer.apple.com/library/ios/documentation/CoreData/Reference/NSFetchedResultsController_Class/Reference/Reference.html
[uicollectionviewcontroller]: https://developer.apple.com/library/ios/documentation/uikit/reference/UICollectionView_class/Reference/Reference.html


