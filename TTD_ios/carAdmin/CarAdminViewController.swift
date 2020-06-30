//
//  CarAdminViewController.swift
//  TTD_ios
//
//  Created by Attila Janosi on 27/09/2019.
//  Copyright © 2019 EXERA SOTDEVELOP SRL. All rights reserved.
//

import UIKit
import Haptico

class CarAdminViewController: EXRViewController {
    
    private let viewModel = CarAdminViewModel()
    
    public static func newInstance() -> CarAdminViewController {
        let viewController = CarAdminViewController()
        return viewController
    }
    
    func isChild() -> Bool {
        return true
    }
    
    private static let cornerRadius: CGFloat = 10
    
    //TOP VIEW
    
    private let topContainer = UIView()
    
    private let vehicleImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = Colors.black.cgColor
        imageView.layer.borderWidth = 2
        imageView.image = R.image.carJpg()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    private let lockButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = cornerRadius
        button.backgroundColor = Colors.colorPrimaryDark
        button.setImage(R.image.unlock()!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(R.image.lock()!.withRenderingMode(.alwaysTemplate), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        return button
    }()
    
    private let titleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.colorPrimaryDark
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private let titleText: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 14
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = Constants.DEVICE_ID
        return label
    }()
    
    //TOP VIEW END
    
    //BATTERY VIEW
    
    private let batteryContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.colorPrimaryDark
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private let batteryView = UIView()
    
    private let batteryIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.zap()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let batteryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.battery()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let batteryPercent: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 14
        label.text = "%"
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let batteryState: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 12
        label.text = "..."
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //BATTERY VIEW END
    
    //MOVING VIEW
    
    private let movingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.colorPrimaryDark
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private let movingView = UIView()
    
    private let movingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.moving()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let movingState: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 14
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MOVING VIEW END
    
    //LAST SYNC VIEW
    
    private let lastSyncContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.colorPrimaryDark
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private let lastSyncView = UIView()
    
    private let lastSyncIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.refresh()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let lastSyncState: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 14
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let onlineState: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 14
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    //LAST SYNC VIEW END
    
    //CONNECTION VIEW
    
    private let connectionContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.colorPrimaryDark
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private let connectionView = UIView()
    
    private let connectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.radio()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let connectionType: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 10
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let connectionState: ExrLabel = {
        let label = ExrLabel()
        label.textColor = Colors.light_text
        label.fontSize = 14
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    //CONNECTION VIEW END
    
    //LOCATION VIEW
    
    private let locationContainer: UIView = {
           let view = UIView()
           view.backgroundColor = Colors.colorPrimaryDark
           view.layer.cornerRadius = cornerRadius
           return view
       }()
       
       private let locationView = UIView()
       
    
    //LOCATION VIEW END
    
    //NAVIGATION VIEW
    
    private let navigation: UISegmentedControl = {
        let items = [R.string.localizable.live(), R.string.localizable.history()]
       let control = UISegmentedControl(items: items)
//        control.setImage(<#T##image: UIImage?##UIImage?#>, forSegmentAt: <#T##Int#>)
        return control
    }()
    
    //NAVIGATION VIEW END
    
    func initView() {
        self.mainView.backgroundColor = Colors.colorPrimary
        createTopView()
        createBatteryView()
        createMovingView()
        createLastSyncView()
        createConnectionView()
        createLocationView()
        addNavigation()
        self.subscribeForLiveData()
    }
    
    private func createTopView(){
        
        mainView.addSubview(topContainer)
        topContainer.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        topContainer.addSubview(vehicleImage)
        vehicleImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo((screenWidth()-80)/3)
            make.width.equalTo((screenWidth()-80)/3)
        }
        
        topContainer.addSubview(lockButton)
        lockButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(60)
            make.height.equalTo((screenWidth()-80)/3 - 45)
        }
        
        topContainer.addSubview(titleContainer)
        titleContainer.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(35)
            make.left.equalTo(vehicleImage.snp.right).offset(15)
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo(((screenWidth()-80)/3)*2 - 60)
            make.height.equalTo(30)
        }
        
        titleContainer.addSubview(titleText)
        titleText.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(-7)
            make.centerY.equalToSuperview()
        }
        
    }
    
    private func createBatteryView(){
        
        mainView.addSubview(batteryContainer)
        batteryContainer.snp.makeConstraints { (make) in
            make.top.equalTo(topContainer.snp.bottom)
            make.left.equalToSuperview().offset(25)
            make.width.equalTo((screenWidth()-80)/3)
            make.height.equalTo((screenWidth()-80)/3)
        }
        
        batteryContainer.addSubview(batteryIcon)
        batteryIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(7)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        
        batteryContainer.addSubview(batteryView)
        batteryView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        batteryView.addSubview(batteryState)
        batteryState.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(60)
        }
        
        batteryView.addSubview(batteryImage)
        batteryImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(batteryState.snp.top).offset(-5)
            make.left.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        batteryView.addSubview(batteryPercent)
        batteryPercent.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(batteryState.snp.top).offset(-5)
            make.left.equalTo(batteryImage.snp.right).offset(10)
            make.width.equalTo(30)
        }
        batteryState.makeLoadingAnimation()
        batteryPercent.makeLoadingAnimation()
    }
    
    private func createMovingView(){
        mainView.addSubview(movingContainer)
        movingContainer.snp.makeConstraints { (make) in
            make.top.equalTo(topContainer.snp.bottom)
            make.left.equalTo(batteryContainer.snp.right).offset(15)
            make.width.equalTo((screenWidth()-80)/3)
            make.height.equalTo((screenWidth()-80)/3)
        }
        
        movingContainer.addSubview(movingIcon)
        movingIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(7)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        
        movingContainer.addSubview(movingState)
        movingState.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    private func createLastSyncView(){
        mainView.addSubview(lastSyncContainer)
        lastSyncContainer.snp.makeConstraints { (make) in
            make.top.equalTo(topContainer.snp.bottom)
            make.left.equalTo(movingContainer.snp.right).offset(15)
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo((screenWidth()-80)/3)
            make.height.equalTo((screenWidth()-80)/3)
        }
        
        lastSyncContainer.addSubview(lastSyncIcon)
        lastSyncIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(7)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        
        lastSyncContainer.addSubview(lastSyncView)
        lastSyncView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.center.equalToSuperview()
        }
        
        lastSyncView.addSubview(onlineState)
        onlineState.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        lastSyncView.addSubview(lastSyncState)
        lastSyncState.snp.makeConstraints { (make) in
            make.top.equalTo(onlineState.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func createConnectionView(){
        topContainer.addSubview(connectionContainer)
        connectionContainer.snp.makeConstraints { (make) in
            make.bottom.equalTo(topContainer.snp.bottom).offset(-15)
            make.top.equalTo(titleContainer.snp.bottom).offset(15)
            make.left.equalTo(vehicleImage.snp.right).offset(15)
            make.right.equalTo(lockButton.snp.left).offset(-15)
            make.width.equalTo(((screenWidth()-80)/3)*2 - 60)
        }
        
        connectionContainer.addSubview(connectionIcon)
        connectionIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(7)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        
        connectionContainer.addSubview(connectionState)
        connectionState.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.center.equalToSuperview()
        }
        
        connectionContainer.addSubview(connectionType)
        connectionType.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(7)
            make.height.equalTo(15)
        }
    }
    
    private func createLocationView(){
        mainView.addSubview(locationContainer)
        locationContainer.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset( -((screenWidth()-80)/3 + 25))
            make.top.equalTo(batteryContainer.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(25)
            make.width.equalTo(((screenWidth()-55)/3)*2)
        }
        
        
               let controller = LiveMapViewController.newInstance(viewModel: viewModel)
               //add as a childviewcontroller
               addChild(controller)
               // Add the child's View as a subview
               self.locationContainer.addSubview(controller.view)
               controller.view.frame = locationContainer.bounds
               controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               
               // tell the childviewcontroller it's contained in it's parent
               controller.didMove(toParent: self)
       
    }
    
    private func addNavigation(){
        mainView.addSubview(navigation)
        navigation.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    
}


//LIVE DATA
extension CarAdminViewController {
    
    private func subscribeForLiveData(){
        
        lockButton.rx.tap
            .asDriver()
            .throttle(0.1)
            .drive(onNext: { (_) in
                Haptico.shared().generate(.medium)
                self.viewModel.setLocked()
            }).disposed(by: disposeBag)
        
        viewModel.liveLocked.asDriver()
            .drive(onNext: { (locked) in
                self.lockButton.isSelected = locked
               
                self.lockButton.tintColor = locked ? Colors.red : Colors.light_text
                
            }).disposed(by: disposeBag)
        
        viewModel.liveBatteryPercent.asDriver()
            .drive(onNext: { (percent) in
                self.batteryPercent.text = "\(percent)%"        
            }).disposed(by: disposeBag)
        
        viewModel.liveBatteryState.asDriver()
            .drive(onNext: { (state) in
                switch(state){
                case Constants.BATTERY_CHARGING:
                    self.batteryImage.image = R.image.battery_charging()
                    self.batteryState.text = R.string.localizable.state_charging()
                    break
                case Constants.BATTERY_DISCHARGING:
                    self.batteryImage.image = R.image.battery_discharging()
                    self.batteryState.text = R.string.localizable.state_discharging()
                    break
                case Constants.BATTERY_FULL:
                    self.batteryImage.image = R.image.battery_full()
                    self.batteryState.text = R.string.localizable.state_full()
                    break
                case Constants.BATTERY_LOW:
                    self.batteryImage.image = R.image.battery_empty()
                    self.batteryState.text = R.string.localizable.state_low()
                    break
                default:
                    self.batteryImage.image = R.image.battery()
                    self.batteryState.text = "..."
                    break
                }
            }).disposed(by: disposeBag)
        
        viewModel.liveMoving.asDriver()
            .drive(onNext: { (moving) in
                if moving {
                    self.movingState.text = R.string.localizable.moving()
                    self.movingState.textColor = Colors.red
                }else{
                    self.movingState.text = R.string.localizable.still()
                    self.movingState.textColor = Colors.green
                }
            }).disposed(by: disposeBag)
        
        viewModel.liveLastSync.asDriver()
            .drive(onNext: { (millis) in
                if millis > 0 {
                let milisecond = millis
                let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)/1000)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MMM.yyyy\nHH:mm:ss"
                    self.lastSyncState.text = dateFormatter.string(from: dateVar)}
            }).disposed(by: disposeBag)
        
        viewModel.liveIsOnline.asDriver()
            .drive(onNext: { (isOnline) in
                self.onlineState.textColor = isOnline ? Colors.green : Colors.red
                self.onlineState.text = isOnline ? R.string.localizable.online() : R.string.localizable.offline()
            }).disposed(by: disposeBag)
        
        viewModel.liveConnectionType.asDriver()
            .drive(onNext: { (_) in
                self.setConnectionType()
            }).disposed(by: disposeBag)
        
        viewModel.liveConnectionStrength.asDriver()
            .drive(onNext: { (_) in
                self.setConnectionStrengthText()
            }).disposed(by: disposeBag)
        
        viewModel.liveCellConnectionType.asDriver()
            .drive(onNext: { (_) in
                self.setConnectionType()
            }).disposed(by: disposeBag)
        
    }
    
}

extension CarAdminViewController {
    
    private func setConnectionStrengthText(){

        var text = ""

            switch viewModel.liveConnectionStrength.value {
            case 4:
                text = R.string.localizable.excelent()
            case 3: 
                text = R.string.localizable.good()
            case 2:
                text = R.string.localizable.weak()
            case 1: 
                text = R.string.localizable.very_weak() 
            default:
                doNothing()
            }
        
        self.connectionState.text = text
    }
    
    private func setConnectionType(){
                if(viewModel.liveConnectionType.value == Constants.UNKNOWN_INT){
                    self.connectionIcon.image = R.image.radio()
                    self.connectionType.isHidden = true
                    self.connectionIcon.isHidden = false
                    return
                }
        
        if viewModel.liveConnectionType.value == Constants.CONNECTION_TYPE_WIFI {
            self.connectionIcon.image = R.image.wifi()
            self.connectionType.isHidden = true
            self.connectionIcon.isHidden = false
        }else{
            if viewModel.liveCellConnectionType.value != ""{
                self.connectionType.text = viewModel.liveCellConnectionType.value
                self.connectionType.isHidden = false
                self.connectionIcon.isHidden = true
            }
        }
    }
    
}
