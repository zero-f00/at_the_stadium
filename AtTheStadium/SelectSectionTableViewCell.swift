//
//  SelectSectionTableViewCell.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/04/17.
//

import UIKit
import FirebaseUI

class SelectSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSectionData(_ sectionData: SectionData) {
        self.sectionName.text = "\(sectionData.section!)"
        print(sectionName.text!)
    }
    
}
