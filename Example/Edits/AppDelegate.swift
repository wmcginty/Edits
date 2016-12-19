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
        
        let transformer1 = TransformerFactory.transformer(from: "hello", to: "olleh")
        print(transformer1.minEditDistance)
        print(transformer1.editSteps)
        print()
        
        let transformer2 = TransformerFactory.transformer(from: "words", to: "sword")
        print(transformer2.minEditDistance)
        print(transformer2.editSteps)
        print()
        
        let transformer3 = TransformerFactory.transformer(from: "racecar", to: "racer")
        print(transformer3.minEditDistance)
        print(transformer3.editSteps)
        
        return true
    }
}

