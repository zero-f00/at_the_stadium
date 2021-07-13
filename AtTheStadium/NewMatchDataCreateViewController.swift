//
//  NewMatchDataCreateViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/15.
//

import UIKit
import Firebase
import SVProgressHUD

class NewMatchDataCreateViewController: UIViewController {
    
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var section: UITextField!
    @IBOutlet weak var homeTeamName: UITextField!
    @IBOutlet weak var awayTeamName: UITextField!
    @IBOutlet weak var stadiumName: UITextField!
    @IBOutlet weak var matchDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createNewMatchDataButton(_ sender: Any) {
        let postRef = Firestore.firestore().collection(Const.NewMatchDataCreatePath).document()
        
        SVProgressHUD.show()
        
        let postDic = [
            "category": self.category.text!,
            "section": self.section.text!,
            "homeTeamName": self.homeTeamName.text!,
            "awayTeamName": self.awayTeamName.text!,
            "stadiumName": self.stadiumName.text!,
            "date": self.matchDatePicker.date,
        ] as [String : Any]
        
        postRef.setData(postDic)
        
        SVProgressHUD.showSuccess(withStatus: "試合情報を作成しました。")
        self.navigationController?.popViewController(animated: true)
    }
}
