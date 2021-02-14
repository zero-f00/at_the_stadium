//
//  PostViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/01/21.
//

import UIKit

class PostViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    fileprivate let placeholder: String = "今日の試合はどんな感じ？" // プレースホルダ
    fileprivate var maxWordCount: Int = 300 // 最大文字数
    @IBOutlet weak var keyboardBackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyboardBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        
        if textView.text.isEmpty {
            textView.textColor = .darkGray
            textView.text = placeholder
            self.wordCountLabel.text = "300/300"
        }
        
        //        // タップでキーボードを下げる
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //        self.view.addGestureRecognizer(tapGesture)
        //        // 下にスワイプでキーボードを下げる
        //        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //        swipeDownGesture.direction = .down
        //        self.view.addGestureRecognizer(swipeDownGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // 遷移時にtextViewにフォーカスをあてる
        self.textView.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        self.keyboardBackView.addBorder(width: 0.5, color: UIColor.black, position: .top)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let suggestionHeight = self.keyboardBackViewConstraint.constant + keyboardSize.height
            self.keyboardBackViewConstraint.constant = suggestionHeight
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension PostViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let existingLines = textView.text.components(separatedBy: .newlines) // すでに存在する改行数
        let newLines = text.components(separatedBy: .newlines) // 新規改行数
        let linesAfterChange = existingLines.count + newLines.count - 1 // 最終回行数。-1は編集したら必ず1行としてカウントされるため
        return linesAfterChange <= 300 && textView.text.count + (text.count - range.length) <= maxWordCount
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let existingLines = textView.text.components(separatedBy: .newlines) // すでに存在する改行数
        if existingLines.count <= 300 {
            self.wordCountLabel.text = "\(maxWordCount - textView.text.count)/300"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .darkText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .darkGray
            textView.text = placeholder
        }
    }
}

enum BorderPosition {
    case top
    case left
    case right
    case bottom
}

extension UIView {
    /// 特定の場所にborderをつける
    ///
    /// - Parameters:
    ///   - width: 線の幅
    ///   - color: 線の色
    ///   - position: 上下左右どこにborderをつけるか
    func addBorder(width: CGFloat, color: UIColor, position: BorderPosition) {
        
        let border = CALayer()
        
        switch position {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .right:
            print(self.frame.width)
            
            border.frame = CGRect(x: self.frame.width - width, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        }
    }
}
