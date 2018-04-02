//
//  ViewController.swift
//  googleMapiOS
//
//  Created by げんと on 2018/03/29.
//  Copyright © 2018年 Gento. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate, LocateOnTheMap, GMSMapViewDelegate, GMSAutocompleteFetcherDelegate, CLLocationManagerDelegate {
    
    @IBAction func goMap(_ segue:UIStoryboardSegue) {}
    

    @IBAction func moveYoutube(_ sender: Any) {
        performSegue(withIdentifier: "nextSegue", sender: nil)
    }
    
    
    
    
    //     * Called when an autocomplete request returns an error.
    //     * @param error the error that was received.
    public func didFailAutocompleteWithError(_ error: Error) {
               //resultText?.text = error.localizedDescription
    }
    
    //     * Called when autocomplete predictions are available.
    //     * @param predictions an array of GMSAutocompletePrediction objects.
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        for prediction in predictions {
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    //@IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var googleMapsContainer: UIView!
    
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var placesClient: GMSPlacesClient!
    private var zoomLevel: Float = 15.0
    /// 初期描画の判断に利用
    private var initView: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let camera = GMSCameraPosition.camera(withLatitude:47.603,
                                              longitude:-122.331,
                                              zoom:15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        self.view = mapView
        let position = CLLocationCoordinate2D(latitude:47.603,
                                              longitude:-122.331)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.snippet = "Population: 8,174,100"
        marker.map = mapView
        
        setupViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }
    
    @IBAction func autocompleteClicked(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated:true, completion: nil)
    }
    
//    func showPartyMarkers(lat: Double, long: Double) {
//        mapView.clear()
//        //for i in 0..<3 {
//            for _ in 0..<3 {
//            let randNum=Double(arc4random_uniform(30))/10000
//            let marker=GMSMarker()
//
//            //let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
//            //marker.iconView=customMarker
//
//            let randInt = arc4random_uniform(4)
//            if randInt == 0 {
//                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
//            } else if randInt == 1 {
//                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
//            } else if randInt == 2 {
//                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
//            } else {
//                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
//            }
//            marker.map = self.mapView
//        }
//    }
    
    
    
    
    //DetailsVCに遷移する処理
    @objc func restaurantTapped(tag: Int) {
        let v=DetailsVC()
        //v.passedData = previewDemoData[tag]
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    //     Locate map with longitude and longitude after search location on UISearchBar
    //     - parameter lon:   longitude location
    //     - parameter lat:   latitude location
    //     - parameter title: title of address location
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async { () -> Void in
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 15)
            let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            mapView.delegate = self
            self.view = mapView
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            marker.title = "Address : \(title)"
            marker.map = mapView
        }
    }
    
    //ランドマークをinforwindowに出す
    // Declare GMSMarker instance at the class level.
    let infoMarker = GMSMarker()
    // Attach an info window to the POI using the GMSMarker.
    func mapView(_ mapView:GMSMapView, didTapPOIWithPlaceID placeID:String,
                 name:String, location:CLLocationCoordinate2D) {
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }
    
    //     Searchbar when text change
    //     - parameter searchBar:  searchbar UI
    //     - parameter searchText: searchtext description
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:GMSMapViewDelegate マップタッチで緯度経度ゲット
    func mapView(_ mapView:GMSMapView, didTapAt coordinate:CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        let position = coordinate
        let marker = GMSMarker(position: position)
        mapView.clear()
        marker.title = "Hello World"
        marker.snippet = "Population: 8,174,100"
        marker.map = mapView
    }
    
    private func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        //markerは情報ウィンドウをタップされたmarker
        //処理....
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        //        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        //let data = previewDemoData[customMarkerView.tag]
        
        //guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        //let data = previewDemoData[customMarkerView.tag]
        //restaurantPreviewView.setData(title: data.title, img: data.img, price: data.price)
        return restaurantPreviewView
    }
    
    func setupViews() {
//        view.addSubview(mapView)
//        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
//        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
//        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
//        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive=true
//
//        self.view.addSubview(txtFieldSearch)
//        txtFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive=true
//        txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
//        txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
//        txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
//        setupTextField(textField: txtFieldSearch, img: #imageLiteral(resourceName: "map_Pin"))
        
//        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        
        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: 400, height: 220))
        
//        self.view.addSubview(btnMyLocation)
//        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive=true
//        btnMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
//        btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
//        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
    }
    
//    //追加
//    let mapView: GMSMapView = {
//        let v=GMSMapView()
//        v.translatesAutoresizingMaskIntoConstraints=false
//        return v
//    }()
    
    
    var restaurantPreviewView: RestaurantPreviewView = {
        let v=RestaurantPreviewView()
        return v
    }()
}


extension ViewController: GMSAutocompleteViewControllerDelegate {

    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }

    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}


