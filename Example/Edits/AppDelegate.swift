//
//  AppDelegate.swift
//  Edits
//
//  Created by William McGinty on 11/07/2016.
//  Copyright (c) 2016 William McGinty. All rights reserved.
//

import UIKit
import Edits

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let source = "words"
        let destination = "sword"
        let transformer = TransformerFactory.transformer(from: source, to: destination)
        print(transformer.editSteps)
        
        return true
    }
}

