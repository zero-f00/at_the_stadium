//
//  CreateTeamViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/05/12.
//

import UIKit
import Firebase
import SVProgressHUD

class CreateTeamViewController: UIViewController {
    
    @IBOutlet weak var homeTeamTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTeamTextField.becomeFirstResponder()
    }
    
    @IBAction func createButton(_ sender: Any) {
        let postRef = Firestore.firestore().collection(Const.HomeTeamPath).document()
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        let uid = Auth.auth().currentUser?.uid
        let postDic = [
            "homeTeam": self.homeTeamTextField.text!,
            "uid": uid!
        ] as [String : Any]
        postRef.setData(postDic)
        
        SVProgressHUD.showSuccess(withStatus: "ホームチームを登録しました。")
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
