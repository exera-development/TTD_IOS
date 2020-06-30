//
//  ExrUiLabel.swift
//  TTD_ios
//
//  Created by Attila Janosi on 07/10/2019.
//  Copyright © 2019 EXERA SOTDEVELOP SRL. All rights reserved.
//

import UIKit

class ExrLabel: UILabel {
    
     override public var text: String? {
        didSet {
            layoutIfNeeded()
            stopLoadingAnimation()
        }
    }
    
    private var timer: Timer?
    
    public func makeLoadingAnimation() {
        
        self.text = "\(R.string.localizable.loading()) ."
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.55, repeats: true) { (timer) in
            var string: String {
                switch self.text {
                case ".":       return ".."
                case "..":      return "..."
                case "...":     return "."
                default:                return ""
                }
            }
            self.text = string
        }
        
    }
    
    public func stopLoadingAnimation() {
        //Stop the timer
        timer?.invalidate()
    }
}
