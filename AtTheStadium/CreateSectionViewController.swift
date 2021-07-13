//
//  CreateSectionViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/04/17.
//

import UIKit
import Firebase
import SVProgressHUD

class CreateSectionViewController: UIViewController {

    @IBOutlet weak var sectionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sectionTextField.becomeFirstResponder()
    }
    
    @IBAction func createButton(_ sender: Any) {
        let postRef = Firestore.firestore().collection(Const.SectionPath).document()
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        let uid = Auth.auth().currentUser?.uid
        let postDic = [
            "section": self.sectionTextField.text!,
            "uid": uid!
        ] as [String : Any]
        postRef.setData(postDic)
        
        SVProgressHUD.showSuccess(withStatus: "セクションを登録しました。")
        self.navigationController?.popViewController(animated: true)
    }
    

}
