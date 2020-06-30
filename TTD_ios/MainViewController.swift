//
//  ViewController.swift
//  TTD_ios
//
//  Created by Attila Janosi on 27/09/2019.
//  Copyright © 2019 EXERA SOTDEVELOP SRL. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: EXRViewController {
    
    func isChild() -> Bool {
        return false
    }
    
    private let container: UIView = {
        let view = UIView()
        return view
    }()
    
    func initView() {
        addContainer()
        showCarAdmin()
    }
    
    private func addContainer(){
        self.mainView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func showCarAdmin(){
        let controller = CarAdminViewController.newInstance()
        //add as a childviewcontroller
        addChild(controller)
        // Add the child's View as a subview
        self.container.addSubview(controller.view)
        controller.view.frame = container.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
    }
    
    
}

extension MainViewController{
    
    
    
}

