////
////  PostContoller.swift
////  fe_sagareal
////
////  Created by 川田隼輔 on R 6/03/07.
////
//
//import Foundation
//import UIKit
//import AVFoundation
//

import UIKit
import AVFoundation
import FirebaseStorage
import CoreLocation

class PostController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate{
    
    var currentLocation:CLPlacemark?

    //CoreLocationManagerのインスタンス化
    let locationManager = CLLocationManager()
    
    var takenImage: UIImage? = nil
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateメソッドの設定(位置情報のために必要)
        locationManager.delegate = self
        //ロードされた時に位置情報を取得
        locationManager.requestLocation()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("Image not found.")
            return
        }
        
        cameraImageView.image = image
        takenImage = image
    }
    
    @IBAction func takeButtonTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
    
            //UIImagePickerControllerを作成
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
         }
         else {
             print("Camera not available.")
         }
    }
    
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        
        var prefecture:String
        
        if let currentLocation = self.currentLocation {
            //強制unwrap
            prefecture =  currentLocation.administrativeArea!
            if(prefecture == "佐賀県"){
                print("\(prefecture)です")
            }else{
                print("\(prefecture)ではありません")
            }
        } else {
            return
        }
        //ガード節
        guard let uploadImage = takenImage else {
            print("No image to upload.")
            return
        }
        // 画像をNSDataに変換
        guard let imageData = uploadImage.toData() else {
            print("Failed to convert image to data.")
            return
        }
        //参照の作成
        let storage = Storage.storage()
        let storagePath = "gs://sagareal-99b79.appspot.com/test.jpg"
        let storageRef = storage.reference(forURL: storagePath)
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let uploadTask = storageRef.putData(imageData, metadata: meta) { (metadata, error) in
          storageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              return
            }
            print(downloadURL)
          }
        }
        print(uploadTask)
    }
    
    //位置情報の取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last {
            print("location: \(location)") // CLLocationManagerクラスで取得した位置情報
            print("緯度: \(location.coordinate.latitude)")
            print("経度: \(location.coordinate.longitude)")
            
            
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                guard let placemark = placemarks?.first, error == nil else { return }
                // placemarkの値を使用する処理をここに書く
                print(type(of: placemark))
                self.currentLocation = placemark
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
}

//UIImageオブジェクトの拡張
extension UIImage {
    func toData() -> Data? {
        // 画像をJPEG形式のデータに変換
        guard let imageData = self.jpegData(compressionQuality: 0.8) else {
            // 変換に失敗した場合はnilを返す
            return nil
        }
        return imageData
    }
}
