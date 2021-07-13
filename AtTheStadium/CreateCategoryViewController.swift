//
//  CreateCategoryViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/30.
//

import UIKit
import Firebase
import SVProgressHUD

class CreateCategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        categoryTextField.becomeFirstResponder()
    }
    
    @IBAction func createButton(_ sender: Any) {
        let postRef = Firestore.firestore().collection(Const.CategoryPath).document()
        
        SVProgressHUD.show()
        
        let uid = Auth.auth().currentUser?.uid
        let postDic = [
            "category": self.categoryTextField.text!,
            "uid": uid!
        ] as [String : Any]
        postRef.setData(postDic)
        
        SVProgressHUD.showSuccess(withStatus: "セクションを登録しました。")
        self.navigationController?.popViewController(animated: true)
    }
}
