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
    
    var mapView = GMSMapView()
    
    var locationManager = CLLocationManager()
    var didFindMyLoc = false
    
    var locName = [String]()
    var locSubName = [String]()
    var locGeoPointLat = [CLLocationDegrees]()
    var locGeoPointLong = [CLLocationDegrees]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
//        Alamofire.request(.GET, "https://api.daycareiq.com/parents/cities/calgary/summarized_locations", parameters: nil)
//            .response { request, response, data, error in
//                println(request)
//                println(response)
//                println(error)
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        var camera = GMSCameraPosition.cameraWithLatitude(51.013117, longitude: -114.0741555, zoom: 11)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        
        self.view = mapView
        
        
        //        //position of map marker
        //        var position = CLLocationCoordinate2DMake(51.013117, -114.0741555)
        //        var daycareIq = GMSMarker(position: position)
        //        daycareIq.title = "DaycareIQ HQ"
        //        daycareIq.snippet = "Population: 2"
        //        daycareIq.map = mapView
        
        // OLD PARSE DATA QUERY, TO BE REPLACED BY A JSON
        
        //        let query:PFQuery = PFQuery(className: "locations")
        //        query.findObjectsInBackgroundWithBlock{ (objects:[AnyObject]? , error:NSError?)-> Void in
        //            if !(error != nil){
        //                for object in objects!   {
        //                    self.locName.append(object["locName"] as! String)
        //                    self.locSubName.append(object["type"] as! String)
        //                    self.locGeoPoint.append(object["locGeoPoint"] as! PFGeoPoint)
        //                    self.locGeoPointLat.append(self.locGeoPoint.last?.latitude as CLLocationDegrees!)
        //                    self.locGeoPointLong.append(self.locGeoPoint.last?.longitude as CLLocationDegrees!)
        //
        //                    var position = CLLocationCoordinate2DMake(self.locGeoPointLat.last!, self.locGeoPointLong.last!)
        //                    var marker = GMSMarker(position: position)
        //                    marker.appearAnimation = kGMSMarkerAnimationPop
        //                    marker.title = self.locName.last!
        //                    marker.snippet = self.locSubName.last!
        //                    //marker.icon = UIImage(named: "bubble")
        //                    marker.map = self.mapView
        //                }
        //            }
        //        }
        
        
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        
    }
    
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView {
        var infoWindow = NSBundle.mainBundle().loadNibNamed("CustomInfoWindow", owner: self, options: nil).first! as!CustomInfoWindow
        infoWindow.locationName.text = "test"
        
        return infoWindow
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.myLocationEnabled = true
        }
    }
    
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if !didFindMyLoc {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10)
            mapView.settings.myLocationButton = true
            
            didFindMyLoc = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

