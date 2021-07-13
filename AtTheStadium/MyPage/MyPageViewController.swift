//
//  MyPageViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/05/20.
//

import UIKit
import Firebase
import FirebaseUI
import SVProgressHUD
import UITextView_Placeholder

class MyPageViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var favoriteTeam: UITextField!
    @IBOutlet weak var selfIntroductionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.setUnderLine()
        favoriteTeam.setUnderLine()
        
        userName.delegate = self
        favoriteTeam.delegate = self
        selfIntroductionTextView.delegate = self
        
        
        // 自己紹介プレースホルダ
        self.selfIntroductionTextView.attributedPlaceholder = NSAttributedString(string: "お気に入りの選手、ユニフォーム、スタジアムについて発信しよう！", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
            }
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // 文字数制限
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength: Int = 0
        
        switch (textField.tag) {
        case 1:
            maxLength = 15 // ユーザー
        case 2:
            maxLength = 30 // お気に入りのチーム
        default:
            break
        }
        
        let textFieldNum = textField.text?.count ?? 0
        let stringNum = string.count
        
        return textFieldNum + stringNum <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension UITextField {
    func setUnderLine() {
        
        borderStyle = .none
        let underline = UIView()
        
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 0.5)
        
        underline.backgroundColor = .gray
        addSubview(underline)
        
        bringSubviewToFront(underline)
    }
}

