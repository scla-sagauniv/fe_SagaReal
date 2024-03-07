//
//  ViewController.swift
//  fe_sagareal
//
//  Created by 川田隼輔 on R 6/03/04.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController ,CLLocationManagerDelegate{
    
    //CoreLocationManagerのインスタンス化
    let locationManager = CLLocationManager()
    // 通知許可を求める
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        //戻るボタンを非表示にする　デバッグ用に戻るボタンを残す
//　　　　　navigationController?.navigationBar.isHidden = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("通知許可が得られました")
            }
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    @IBAction func testMainButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Test", bundle: nil)
        let registerNewTeamController = storyboard.instantiateViewController(withIdentifier: "TestController")
        //navigationControllerクラスがない場合はメソッドそのものが呼び出されない

        self.navigationController?.pushViewController(registerNewTeamController, animated: true)
    }
    
}

