//
//  AppConfig.swift
//  OHTreesAppConfig
//
//  Created by Paul Bunting on 11/26/15.
//  Copyright © 2015 Paul Bunting. All rights reserved.
//

import Foundation

public class AppConfig {
    
    private struct Bundle {
        static var prefix = NSBundle.mainBundle().bundleIdentifier
    }
    
    struct ApplicationGroups {
        static let primary = "group.\(Bundle.prefix!).documents"
    }
    
    private struct Defaults {
        static let firstLaunchKey = "AppConfig.Defaults.firstLaunchKey"
//        static let storageOptionKey = "AppConfig.Defaults.storageOptionKey"
//        static let storedUbiquityIdentityToken = "AppConfig.Defaults.storedUbiquityIdentityToken"
    }

    // Provide singleton access
    //
    public class var sharedAppConfig: AppConfig {
        struct Singleton {
            static let sharedAppConfig = AppConfig()
        }
        
        return Singleton.sharedAppConfig
    }

    private var applicationUserDefaults: NSUserDefaults {
        NSLog("ApplicationGroups.primary \(ApplicationGroups.primary)")
        return NSUserDefaults(suiteName: ApplicationGroups.primary)!
    }
    
    public func get(key:String) -> AnyObject? {
        if let value = applicationUserDefaults.objectForKey(key) {
            return value
        }
        return nil
    }
    
    public func set(key: String, value: AnyObject) {
        applicationUserDefaults.setObject(value, forKey: key)
    }
    
    public func remove(key: String) {
        applicationUserDefaults.removeObjectForKey(key)
    }
    
    public private(set) var isFirstLaunch: Bool {
        get {
            registerDefaults()
            NSLog("Fetching \(Defaults.firstLaunchKey) = \(applicationUserDefaults.boolForKey(Defaults.firstLaunchKey))")
            return applicationUserDefaults.boolForKey(Defaults.firstLaunchKey)
        }
        set {
            applicationUserDefaults.setBool(newValue, forKey: Defaults.firstLaunchKey)
        }
    }
    
    private func registerDefaults() {
        #if os(iOS)
            let defaultOptions: [String: AnyObject] = [
                Defaults.firstLaunchKey: true,
            ]
        #elseif os(watchOS)
            let defaultOptions: [String: AnyObject] = [
                Defaults.firstLaunchKey: true
            ]
        #elseif os(OSX)
            let defaultOptions: [String: AnyObject] = [
                Defaults.firstLaunchKey: true
            ]
        #endif
        
        applicationUserDefaults.registerDefaults(defaultOptions)
    }

    public func runHandlerOnFirstLaunch(firstLaunchHandler: Void -> Void) {
        if isFirstLaunch {
            isFirstLaunch = false
            
            firstLaunchHandler()
        }
    }

}