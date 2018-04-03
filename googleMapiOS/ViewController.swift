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
//
class ViewController: UIViewController, GMSMapViewDelegate {
    
    struct State {
        let lat: CLLocationDegrees
        let long: CLLocationDegrees
    }
    
    let states = [
        State(lat: 47.6080925784177, long: -122.327423729002),
        State(lat: 47.6097899041662, long: -122.333718203008),
        State(lat: 47.594839382953, long: -122.33772341162),
        State(lat: 47.5941158586167, long: -122.327395230532),
        State(lat: 47.6078805501033, long: -122.320128120482),
        State(lat: 47.603111111111, long: -122.3311111111111)
    ]
    
    
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
            //let state_marker = GMSMarker()
            let position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            let state_marker = GMSMarker(position: position)
            state_marker.map = mapView
        }
    }
    
    @IBAction func goMap(_ segue:UIStoryboardSegue) {}
    

    @IBAction func moveYoutube(_ sender: Any) {
        performSegue(withIdentifier: "nextSegue", sender: nil)
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
        setupMap()
        setupViews()
    }
    
    //DetailsVCに遷移する処理
    //@objc func restaurantTapped(tag: Int){
    @objc func restaurantTapped(){
        let v=DetailsVC()
        //v.passedData = previewDemoData[tag]
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    
    @objc func onTappedPush(_ sender: Any) {
        let v = DetailsVC()
        self.navigationController?.pushViewController(v, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 190))
        restaurantPreviewView=RestaurantPreviewView(frame: CGRect(x: 0, y: 0, width: 400, height: 220))
    }
    
    var restaurantPreviewView: RestaurantPreviewView = {
        let v=RestaurantPreviewView()
        return v
    }()
}

