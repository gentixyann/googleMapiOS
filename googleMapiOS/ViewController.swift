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

//class ViewController: UIViewController, UISearchBarDelegate, LocateOnTheMap, GMSMapViewDelegate, GMSAutocompleteFetcherDelegate, CLLocationManagerDelegate {

class ViewController: UIViewController, GMSMapViewDelegate {
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 60
    
    struct State {
        let lat: CLLocationDegrees
        let long: CLLocationDegrees
        let url: String
        let i: Int
    }
    
    let states = [
        State(lat: 47.6080925784177, long: -122.327423729002, url:"https://www.youtube.com/embed/OVGbAFy36xM", i:1),
        State(lat: 47.6097899041662, long: -122.333718203008, url:"ha2", i:2),
        State(lat: 47.594839382953, long: -122.33772341162, url:"ha3", i:3),
        State(lat: 47.5941158586167, long: -122.327395230532, url:"ha4", i:4),
        State(lat: 47.6078805501033, long: -122.320128120482, url:"ha5", i:5),
        State(lat: 47.603111111111, long: -122.3311111111111, url:"ha6", i:6)
    ]
    
    let previewDemoData = [(title: "The Polar Junction", img: #imageLiteral(resourceName: "restaurant1"), price: 10), (title: "The Nifty Lounge", img: #imageLiteral(resourceName: "restaurant2"), price: 8), (title: "The Lunar Petal", img: #imageLiteral(resourceName: "restaurant3"), price: 12)]
    
    func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude:47.603,
                                              longitude:-122.331,
                                              zoom:15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        self.view = mapView
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        for state in states {
            let position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            let state_marker = GMSMarker(position: position)
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: #imageLiteral(resourceName: "Image-2"), borderColor: UIColor.darkGray, tag: state.i)
            state_marker.iconView=customMarker
            state_marker.map = mapView
            
//            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
            
        }
    }
    
    @IBAction func goMap(_ segue:UIStoryboardSegue) {}
    

    @IBAction func moveYoutube(_ sender: Any) {
        performSegue(withIdentifier: "nextSegue", sender: nil)
    }
    
    @IBOutlet weak var googleMapsContainer: UIView!
    
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var placesClient: GMSPlacesClient!
    private var zoomLevel: Float = 15.0
    private var initView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
        setupMap()
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        //let data = previewDemoData[customMarkerView.tag]
        let data = states[customMarkerView.tag]
        print("dataの中身: \(data)")
        restaurantPreviewView.setData(id: data.i)
        return restaurantPreviewView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("Yeah! Button is tapped!")
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        //DetailsVCに遷移する処理
        restaurantTapped(tag: tag)
        print("DetailsVCに遷移: \(tag)")
    }
    
    //DetailsVCに遷移する処理
    @objc func restaurantTapped(tag: Int){
        let v=DetailsVC()
       //v.passedData = previewDemoData[tag]
        //v.passedData = states[tag]
        print("tagの中身: \(tag)")
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
//        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: 400, height: 220))
    }
    
    var restaurantPreviewView: RestaurantPreviewView = {
        let v=RestaurantPreviewView()
        return v
    }()
}

