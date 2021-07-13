//
//  PostTableViewCell.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/31.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var matchInfoCategoryLabel: UILabel!
    
    @IBOutlet weak var addMatchInfoButton: UIButton!
    @IBOutlet weak var addMatchInfoView: UIView!
    
    @IBOutlet weak var matchInfoHomeT: UILabel!
    @IBOutlet weak var matchInfoAwayT: UILabel!
    @IBOutlet weak var matchInfoDate: UILabel!
    
    @IBOutlet weak var matchInfoStadiumImageView: UIImageView!
    @IBOutlet weak var matchInfoStadiumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // 枠線の色
        addMatchInfoView.layer.borderColor = UIColor.red.cgColor
        // 枠線の太さ
        addMatchInfoView.layer.borderWidth = 3
        // 角丸
        addMatchInfoView.layer.cornerRadius = 5
        addMatchInfoView.layer.masksToBounds = true
    }
    
    func setPostData(_ postData: PostData) {
        // 投稿者の表示
        self.displayName.text = "\(postData.name!)"
        
        // 投稿時の時間
        self.dateLabel.text = ""
        if let date = postData.date {
            self.dateLabel.text = date.toFuzzy()
        }
        
        // キャプションの表示
        self.captionLabel.text = "\(postData.caption!) "
        
        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
}
