//
//  AppDelegate.swift
//  RustOwnershipPassing
//
//  Created by John Gallagher on 10/8/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

func exerciseOwnershipFromRust() {
    let namedData = RustNamedData()
    print("namedData.name = \(namedData.name)")
    print("namedData.count = \(namedData.count)")
}

func exerciseOwnserhipFromSwift() {
    let obj = SwiftObject()
    obj.sendToRust()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        exerciseOwnershipFromRust()
        exerciseOwnserhipFromSwift()

        return true
    }

}

