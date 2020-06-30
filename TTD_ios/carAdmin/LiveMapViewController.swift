//
//  LiveMapViewController.swift
//  TTD_ios
//
//  Created by Attila Janosi on 16/10/2019.
//  Copyright © 2019 EXERA SOTDEVELOP SRL. All rights reserved.
//

import UIKit
import GoogleMaps
import RxGoogleMaps
import RxCocoa
import RxSwift
import Pulsator

class LiveMapViewController: EXRViewController {
    
    func isChild() -> Bool {
        return true
    }
    
    public static func newInstance(viewModel: CarAdminViewModel) -> LiveMapViewController {
        let controller = LiveMapViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    private var viewModel: CarAdminViewModel?
    private var marker: GMSMarker? 
    private var accuracyCircle: GMSCircle?
    
    private let mapView: GMSMapView = {
        let mapview = GMSMapView()
        mapview.layer.cornerRadius = 9
        do {
            // Set the map style by passing a valid JSON string.
            mapview.mapStyle = try GMSMapStyle(jsonString: mapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        return mapview
    }()
    
    
    func initView() {
        self.view.layer.cornerRadius = 10
        self.mainView.layer.cornerRadius = 10
        addMap()
        subscribeForLiveData()
    }
    
    private func addMap(){
        self.mainView.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func subscribeForLiveData(){
        viewModel?.liveLocation.asDriver()
            .drive(onNext: { (location) in
                if location != nil{
                    self.moveMarker(location: location!)
                }
            }).disposed(by: disposeBag)
        
        //        self.mapView.
    }
    
    private func moveMarker(location: ExrLocation){
        if marker == nil {
            marker = GMSMarker()
            marker?.map = mapView
            marker?.isFlat = true
            marker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            marker?.iconView = createMarkerView()
        }
        
        let locValue = CLLocationCoordinate2D(latitude: location.latitudeValue, longitude: location.longitudeValue)
        marker?.position = locValue
        marker?.rotation = CLLocationDegrees(exactly: location.bearingValue)!
        accuracyCircle = GMSCircle(position: locValue, radius: location.accuracyValue)
        accuracyCircle?.map = mapView
        accuracyCircle?.strokeWidth = 1
        accuracyCircle?.fillColor = (viewModel?.liveLocked.value)! ? Colors.accuracyRedTransparent : Colors.accuracyGreenTransparent
        accuracyCircle?.strokeColor = (viewModel?.liveLocked.value)! ? Colors.accuracyRed : Colors.accuracyGreen
        //        accuracyCircle?.radius = 20
        //        accuracyCircle?.position = locValue
        
        mapView.animate(toLocation: locValue)
        let markerPosition = GMSCameraPosition.camera(withLatitude: locValue.latitude,
                                                      longitude: locValue.longitude, zoom: 15)
        mapView.camera = markerPosition
    }
    
    private func delay(seconds: Double, completion:@escaping ()->()) {
        let when = DispatchTime.now() + seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion()
        }
    }
    
    private func createMarkerView() -> UIView {
        let image = UIImageView()
        image.image = R.image.marker()
        image.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        return image
    }
    
}

let mapStyle = """
[
{
"elementType": "geometry",
"stylers": [
{
"color": "#1d2c4d"
}
]
},
{
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#8ec3b9"
}
]
},
{
"elementType": "labels.text.stroke",
"stylers": [
{
"color": "#1a3646"
}
]
},
{
"featureType": "administrative.country",
"elementType": "geometry.stroke",
"stylers": [
{
"color": "#4b6878"
}
]
},
{
"featureType": "administrative.land_parcel",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#64779e"
}
]
},
{
"featureType": "administrative.province",
"elementType": "geometry.stroke",
"stylers": [
{
"color": "#4b6878"
}
]
},
{
"featureType": "landscape.man_made",
"elementType": "geometry.stroke",
"stylers": [
{
"color": "#334e87"
}
]
},
{
"featureType": "landscape.natural",
"elementType": "geometry",
"stylers": [
{
"color": "#023e58"
}
]
},
{
"featureType": "poi",
"elementType": "geometry",
"stylers": [
{
"color": "#283d6a"
}
]
},
{
"featureType": "poi",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#6f9ba5"
}
]
},
{
"featureType": "poi",
"elementType": "labels.text.stroke",
"stylers": [
{
"color": "#1d2c4d"
}
]
},
{
"featureType": "poi.park",
"elementType": "geometry.fill",
"stylers": [
{
"color": "#023e58"
}
]
},
{
"featureType": "poi.park",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#3C7680"
}
]
},
{
"featureType": "road",
"elementType": "geometry",
"stylers": [
{
"color": "#304a7d"
}
]
},
{
"featureType": "road",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#98a5be"
}
]
},
{
"featureType": "road",
"elementType": "labels.text.stroke",
"stylers": [
{
"color": "#1d2c4d"
}
]
},
{
"featureType": "road.highway",
"elementType": "geometry",
"stylers": [
{
"color": "#2c6675"
}
]
},
{
"featureType": "road.highway",
"elementType": "geometry.stroke",
"stylers": [
{
"color": "#255763"
}
]
},
{
"featureType": "road.highway",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#b0d5ce"
}
]
},
{
"featureType": "road.highway",
"elementType": "labels.text.stroke",
"stylers": [
{
"color": "#023e58"
}
]
},
{
"featureType": "transit",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#98a5be"
}
]
},
{
"featureType": "transit",
"elementType": "labels.text.stroke",
"stylers": [
{
"color": "#1d2c4d"
}
]
},
{
"featureType": "transit.line",
"elementType": "geometry.fill",
"stylers": [
{
"color": "#283d6a"
}
]
},
{
"featureType": "transit.station",
"elementType": "geometry",
"stylers": [
{
"color": "#3a4762"
}
]
},
{
"featureType": "water",
"elementType": "geometry",
"stylers": [
{
"color": "#0e1626"
}
]
},
{
"featureType": "water",
"elementType": "labels.text.fill",
"stylers": [
{
"color": "#4e6d70"
}
]
}
]
"""
