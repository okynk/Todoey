//
//  AppDelegate.swift
//  Todoey
//
//  Created by Oky Nugroho Kusumo on 12/01/2018.
//  Copyright © 2018 Oky Nugroho Kusumo. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        do {
            _ = try Realm()
        } catch {
            print("Error realm \(error)")
        }
        
        return true
    }

}

