//
//  SelectCategoryTableViewCell.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/29.
//

import UIKit

class SelectCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCategoryData(_ categoryData: CategoryData) {
        self.categoryName.text = "\(categoryData.category!)"
    }
    
}
