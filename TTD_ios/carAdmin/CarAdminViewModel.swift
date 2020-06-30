//
//  CarAdminViewModel.swift
//  TTD_ios
//
//  Created by Attila Janosi on 29/09/2019.
//  Copyright © 2019 EXERA SOTDEVELOP SRL. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa
import OneSignal
import RxFirebase

class CarAdminViewModel {
    
    private let bag = DisposeBag()
    
    private let carId = Constants.DEVICE_ID
    private let reference =  Database.database().reference()
    public let liveLocked = BehaviorRelay<Bool>(value: false) 
    public let liveMoving = BehaviorRelay<Bool>(value: false)
    
    public let liveBatteryPercent = BehaviorRelay<Int>(value: 0)
    public let liveBatteryState = BehaviorRelay<Int>(value: Constants.BATTERY_INITIAL)
    public let liveLastSync = BehaviorRelay<Int32>(value: 0)
    public let liveConnectionType = BehaviorRelay<Int>(value: -1)
    public let liveConnectionStrength = BehaviorRelay<Int>(value: -1)
    public let liveCellConnectionType = BehaviorRelay<String>(value: "")
    public let liveIsOnline = BehaviorRelay<Bool>(value: false)
    public let liveLocation = BehaviorRelay<ExrLocation?>(value: nil)
    
    init() {
        let sensorReference = reference.child("Devices").child(carId).child(ExrSensor.TAG)
        let sensorInfoReference = reference.child("Devices").child(carId).child(ExrSensorInfo.TAG)
        let controllerReference = reference.child("Devices").child(carId).child(ExrController.TAG)
        let sensorLocationReference = reference.child("Devices").child(carId).child(ExrLocation.TAG)
        
        controllerReference.rx
            .observeSingleEvent(.value)
            .subscribe(onSuccess: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let locked = value?[ExrController.listenerActivated] as? Bool ?? false
                self.liveLocked.accept(locked)
            }).disposed(by: bag)
        
        sensorReference.rx
            .observeEvent(.value)
            .subscribe(onNext: { (snapshot) in
                let value = snapshot.value as? [String : AnyObject]
                let moving = value?[ExrSensor.isMoing] as? Bool ?? false
                let batteryPercent = value?[ExrSensor.batteryPercent] as? Int ?? 0
                let batteryState = value?[ExrSensor.batteryState] as? Int ?? Constants.BATTERY_INITIAL
                let connectionType = value?[ExrSensor.connectionType] as? Int ?? Constants.UNKNOWN_INT
                let connectionStrength = value?[ExrSensor.connectionStrength] as? Int ?? Constants.UNKNOWN_INT
                let cellConnectionType = value?[ExrSensor.cellConnectionType] as? String ?? Constants.UNKNOWN_STRING
                
                self.liveMoving.accept(moving)
                self.liveBatteryPercent.accept(batteryPercent)
                self.liveBatteryState.accept(batteryState)
                self.liveConnectionType.accept(connectionType)
                self.liveConnectionStrength.accept(connectionStrength)
                self.liveCellConnectionType.accept(cellConnectionType)
            }).disposed(by: bag)
        
        sensorInfoReference.rx
            .observeEvent(.value)
            .subscribe(onNext: { (snapshot) in
                let value = snapshot.value as? [String : AnyObject]
                           let lastSync = value?[ExrSensorInfo.lastSync] as? Int32 ?? 0
                           let isOnline = value?[ExrSensorInfo.isOnline] as? Bool ?? false
                           self.liveLastSync.accept(lastSync)
                           self.liveIsOnline.accept(isOnline)
            }).disposed(by: bag)
        
        sensorLocationReference.rx
            .observeEvent(.value)
            .subscribe(onNext: { (snapshot) in
                let value  = snapshot.value as? [String: AnyObject]
                if value != nil{
                    let location = ExrLocation.getLocationFromSnapshot(snapshot: value! )
                    self.liveLocation.accept(location)
                }
            }).disposed(by: bag)
        
        registerForPushNotification()
    }
    
    public func setLocked(){
        let locked = !liveLocked.value
        reference.child("Devices").child(carId).child(ExrController.TAG).child(ExrController.listenerActivated).setValue(locked)
        liveLocked.accept(locked)
    }
    
    private func registerForPushNotification(){
        OneSignal.getTags({ tags in
            print("tags - \(tags!)")
            if tags![self.carId] == nil  {
                OneSignal.sendTag(self.carId, value: "true")
            }
        }, onFailure: { error in
            print("Error getting tags - \(error?.localizedDescription)")
        })
        
    }
    
}


