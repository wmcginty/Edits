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
        
        let transformer1 = Transformer(source: "hello", destination: "olleh")
        print(transformer1.minEditDistance)
        print(transformer1.editSteps)
        print()
        
        let transformer2 = Transformer(source: "words", destination: "sword")
        print(transformer2.minEditDistance)
        print(transformer2.editSteps)
        print()
        
        let transformer3 = Transformer(source: "racecar", destination: "racer")
        print(transformer3.minEditDistance)
        print(transformer3.editSteps)
        print()
        
        let transformer4 = Transformer(source: [1,2,3,4,5], destination: [2,3,4,5,1])
        print(transformer4.minEditDistance)
        print(transformer4.editSteps)
        
        return true
    }
}

