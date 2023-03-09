//
//  TMLocation.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/4.
//

import CoreLocation
import Foundation
import UIKit

class TMLocationManager: NSObject {
    public static let shared = TMLocationManager()

    private var locationManager: CLLocationManager?
    private var viewController: UIViewController? // 承接外部传过来的视图控制器，做弹框处理

    // 外部初始化的对象调用，执行定位处理。
    func startPositioning(completionHandler: @escaping (String) -> Void) {
        if locationManager != nil, CLLocationManager.authorizationStatus() == .denied {
            // 定位提示
        } else {
            requestLocationServicesAuthorization(completionHandler: { string in
                completionHandler(string)
            })
        }
    }

    // 初始化定位
    private func requestLocationServicesAuthorization(completionHandler: @escaping (String) -> Void) {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }

        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()

        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        }

        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            let distance: CLLocationDistance = 10.0
            locationManager?.distanceFilter = distance
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
            let location = locationManager?.location
            getLocationDescription(location: location!, completionHandler: { string in
                completionHandler(string)
            })
        }
    }

    // 获取定位代理返回状态进行处理
    private func reportLocationServicesAuthorizationStatus(status: CLAuthorizationStatus) {
        if status == .notDetermined {
            // 未决定,继续请求授权
            requestLocationServicesAuthorization(completionHandler: { _ in })
        } else if status == .restricted {} else if status == .denied {}
    }

    func getLocationDescription(location: CLLocation, completionHandler: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            if let place = placemarks?[0] {
                // 国家 省  市  区  街道  名称  国家编码  邮编

                let administrativeArea = place.administrativeArea ?? ""
                let locality = place.locality ?? ""
                let subLocality = place.subLocality ?? ""
                let thoroughfare = place.thoroughfare ?? ""
                let name = place.name ?? ""

                let addressLines = administrativeArea + locality + subLocality + thoroughfare + name

                completionHandler(addressLines)
            }
        }
    }
}

extension TMLocationManager: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        locationManager?.stopUpdatingLocation()
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        reportLocationServicesAuthorizationStatus(status: status)
    }

    func locationManager(_: CLLocationManager, didFailWithError _: Error) {
        locationManager?.stopUpdatingLocation()
    }
}
