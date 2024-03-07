//
//  Gallery.swift
//  fe_sagareal
//
//  Created by 川田隼輔 on R 6/03/07.
//

import Foundation
import UIKit

class GalleryController:UIViewController{
    
    
    @IBOutlet weak var toPostButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toPostButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        let postController = storyboard.instantiateViewController(withIdentifier: "PostController")
        //navigationControllerクラスがない場合はメソッドそのものが呼び出されない
        self.navigationController?.pushViewController(postController, animated: true)
    }
}
