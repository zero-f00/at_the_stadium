//
//  PostViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/01/21.
//

import UIKit
import UITextView_Placeholder

class PostViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    fileprivate var maxWordCount: Int = 300 // 最大文字数
    
    @IBOutlet weak var keyboardBackViewConstraint: NSLayoutConstraint! // キーボードが表示されたときViewの高さに変更を加えた場合
    @IBOutlet weak var keyboardBackViewBottomConstraint: NSLayoutConstraint! // キーボードが表示されたときViewのBottomに制約を加えた場合
    
    @IBOutlet weak var keyboardBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        
        if textView.text.isEmpty {
            self.wordCountLabel.text = "300/300"
        }
        
        self.textView.attributedPlaceholder = NSAttributedString(string: "今日の試合はどんな感じ？", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        //        // タップでキーボードを下げる
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //        self.view.addGestureRecognizer(tapGesture)
        //        // 下にスワイプでキーボードを下げる
        //        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //        swipeDownGesture.direction = .down
        //        self.view.addGestureRecognizer(swipeDownGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // 遷移時にtextViewにフォーカスをあてる
        self.textView.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        self.keyboardBackView.topBorder(width: 0.5, color: UIColor.black)
    }
    
    // keyboardBackViewの高さに制約を加えたパターン
    //    @objc func keyboardWillShow(notification: NSNotification) {
    //
    //        let defaultHeightConstraint: CGFloat = 40
    //
    //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
    //
    //            let suggestionHeight = defaultHeightConstraint + keyboardSize.height
    //            self.keyboardBackViewConstraint.constant = suggestionHeight
    //        }
    //    }
    
    // Bottomに制約を加えたパターン
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let suggestionHeight = keyboardSize.height
            self.keyboardBackViewBottomConstraint.constant = suggestionHeight
        }
    }
    
    func addBorder(width: CGFloat, color: UIColor) {
        
        let border = CALayer()
        
        border.frame = CGRect(x: 0, y: 0, width: self.keyboardBackView.frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.keyboardBackView.layer.addSublayer(border)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        if textView.text.isEmpty {
            self.dismiss(animated: true, completion: nil)
        } else {
            let dialog = UIAlertController(title: "投稿をキャンセルしますか？", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            // 削除するボタンの処理
            let confirmAction: UIAlertAction = UIAlertAction(title: "削除する", style: .destructive, handler: {
                // 確定ボタンが押されたときの処理をクロージャ実装
                (action: UIAlertAction!) -> Void in
                // 処理の内容
                self.dismiss(animated: true, completion: nil)
                print("編集をやめて、前の画面に戻る")
            })
            
            // 編集を続けるボタンの処理
            let continueEditing: UIAlertAction = UIAlertAction(title: "編集を続ける", style: .cancel, handler: {
                (action: UIAlertAction!) -> Void in
                // 実際の処理
                print("編集を続けて、textViewにフォーカスをあてる")
                self.textView.becomeFirstResponder()
            })
            
            //UIAlertControllerにキャンセルボタンと確定ボタンをActionを追加
            dialog.addAction(continueEditing)
            dialog.addAction(confirmAction)
            
            self.present(dialog, animated: true, completion: nil)
        }
        
    }
    
    // Bottomに制約を加えたパターン
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let suggestionHeight = keyboardSize.height
            self.keyboardBackViewBottomConstraint.constant -= suggestionHeight
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension PostViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLines = text.components(separatedBy: .newlines) // 新規改行数
        let existingLines = textView.text.components(separatedBy: .newlines) // すでに存在する改行数
        let linesAfterChange = existingLines.count + newLines.count - 1 // 最終回行数。-1は編集したら必ず1行としてカウントされるため
        return linesAfterChange <= 300 && textView.text.count + (text.count - range.length) <= maxWordCount
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let existingLines = textView.text.components(separatedBy: .newlines) // すでに存在する改行数
        if existingLines.count <= 300 {
            self.wordCountLabel.text = "\(maxWordCount - textView.text.count)/300"
        }
    }
}

extension UIView {
    func topBorder(width: CGFloat, color: UIColor) {
        
        let border = CALayer()
        
        border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
