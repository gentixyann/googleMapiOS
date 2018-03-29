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
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var placesClient: GMSPlacesClient!
    private var zoomLevel: Float = 15.0
    /// 初期描画の判断に利用
    private var initView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // GoogleMapの初期化
        self.mapView.isMyLocationEnabled = true
        self.mapView.mapType = GMSMapViewType.normal
        self.mapView.settings.compassButton = true
        self.mapView.settings.myLocationButton = true
        self.mapView.delegate = self
        
        // 位置情報関連の初期化
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.distanceFilter = 50
        self.locationManager?.startUpdatingLocation()
        self.locationManager?.delegate = self
        
        self.placesClient = GMSPlacesClient.shared()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.initView {
            // 初期描画時のマップ中心位置の移動
            let camera = GMSCameraPosition.camera(withTarget: (locations.last?.coordinate)!, zoom: self.zoomLevel)
            self.mapView.camera = camera
            self.locationManager?.stopUpdatingLocation()
            self.initView = true
        }
    }


}

