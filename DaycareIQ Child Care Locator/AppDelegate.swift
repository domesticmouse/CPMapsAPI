//
//  AppDelegate.swift
//  DaycareIQ Child Care Locator
//
//  Created by Craig on 2015-07-20.
//  Copyright (c) 2015 DaycareIQ. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var googleMapsAPI = "apikey"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        GMSServices.provideAPIKey(googleMapsAPI)

        return true
    }

}
