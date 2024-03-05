//
//  TestController.swift
//  fe_sagareal
//
//  Created by 川田隼輔 on R 6/03/04.
//

import Foundation
import UIKit
import CoreLocation
import UserNotifications

//CLLocationManagerDelegateを継承することでCoreLocationを使用できる
class TestController:UIViewController,CLLocationManagerDelegate{
    
    //CoreLocationManagerのインスタンス化
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var testButton: UIButton!
    
    @IBOutlet weak var testAlertBurron: UIButton!
    
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateメソッドの設定
        locationManager.delegate = self

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("location: \(location)") // CLLocationManagerクラスで取得した位置情報
            print("緯度: \(location.coordinate.latitude)")
            print("経度: \(location.coordinate.longitude)")

            
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                guard let placemark = placemarks?.first, error == nil else { return }
                
                // placemarkから必要な情報を取ることができる
                print(placemark.administrativeArea!)
                self.locationLabel.text = placemark.administrativeArea
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    //ボタンを押した時に位置情報を取得する
    @IBAction func testButtonTapped(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    @IBAction func testAlertButtonTapped(_ sender: Any) {
    }
    
    
}
