//
//  Preferences.swift
//  TTD_ios
//
//  Created by Attila Janosi on 05/10/2019.
//  Copyright © 2019 EXERA SOTDEVELOP SRL. All rights reserved.
//

import UIKit

class Preferences: NSObject {
    
    static var appRated: Bool{
        
        get{
            let preferences = UserDefaults.standard
            
            if preferences.object(forKey: "appRated") == nil {
                return true
            } else {
                let value = preferences.bool(forKey: "appRated")
                return value
            }
        }
        
        set{
            let preferences = UserDefaults.standard
            
            preferences.setValue(newValue, forKey: "appRated")
            
            //  Save to disk
            let didSave = preferences.synchronize()
            
            if !didSave {
            }
        }
        
    }
}
