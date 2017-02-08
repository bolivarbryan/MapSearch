# MapSearch
This app that allows users to make searches for locations and present the results in a list, allowing them to be presented in a map view inside the app.

Used pattern MVC

Models Created:
Address: name, full address, coordinate, placeID

CoreData
- iOS 10 Support: 
- Entity name: Location
- Suports Save, Search, List and delete

Controllers

- AddressListViewController: This view shows the results of an address search
- MapViewController: This view shows map location of the place(s) and let user to save them by selecting one of the pins


Pods used

- Alamofire: Library for networking purpouses (REST)
- DZNEmptyDataSet: Library for display a user-friendly Empty state message, in this case, "no results" 
