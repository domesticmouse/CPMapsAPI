//
//  ViewController.swift
//  DaycareIQ Child Care Locator
//
//  Created by Craig on 2015-07-20.
//  Copyright (c) 2015 DaycareIQ. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var mapView: GMSMapView?

    var locationManager = CLLocationManager()
    var didFindMyLoc = false

    var locName = [String]()
    var locSubName = [String]()
    var locGeoPointLat = [CLLocationDegrees]()
    var locGeoPointLong = [CLLocationDegrees]()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()

        var camera = GMSCameraPosition.cameraWithLatitude(51.013117, longitude: -114.0741555, zoom: 11)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView!.myLocationEnabled = true
        mapView!.settings.myLocationButton = true
        self.view = mapView

        mapView!.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
    }

    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView {
        var infoWindow = NSBundle.mainBundle().loadNibNamed("CustomInfoWindow", owner: self, options: nil).first! as!CustomInfoWindow
        infoWindow.locationName.text = "test"
        return infoWindow
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView!.myLocationEnabled = true
        }
    }

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if !didFindMyLoc {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            mapView!.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10)
            mapView!.settings.myLocationButton = true
            didFindMyLoc = true
        }
    }
}
