//
//  OHTreesAppConfigTests.swift
//  OHTreesAppConfigTests
//
//  Created by Paul Bunting on 4/16/16.
//  Copyright © 2016 Paul Bunting. All rights reserved.
//

import Quick
import Nimble
@testable import OHTreesAppConfig


class OHTreesAppConfigTests: QuickSpec {
    
    override func spec() {
    
        describe("OHTreesAppConfig on first launch") {

            let defaults = NSUserDefaults(suiteName: "group.\(NSBundle.mainBundle().bundleIdentifier!).documents")!
            
            var runFirstHandler: Bool!
            
            beforeEach() {
                defaults.removeObjectForKey("AppConfig.Defaults.firstLaunchKey")
                runFirstHandler = false
                NSLog("Resetting NSUserDefaults")
                AppConfig.sharedAppConfig.runHandlerOnFirstLaunch {
                    runFirstHandler = true
                }
            }
            
            it("is first launch") {
                _ = AppConfig.sharedAppConfig
                expect(runFirstHandler).to(equal(true))
            }
    
        }
        
        describe("OHTreesAppConfig after first launch") {
            
            var runFirstHandler: Bool!

            beforeEach() {
                runFirstHandler = false
                AppConfig.sharedAppConfig.runHandlerOnFirstLaunch {
                    runFirstHandler = true
                }
                let appConfig = AppConfig.sharedAppConfig
                expect(runFirstHandler).to(equal(false))
                let appConfigType = Mirror(reflecting: appConfig)
                expect(appConfigType.subjectType == AppConfig.self).to(equal(true))
            }
        }
    }
}
