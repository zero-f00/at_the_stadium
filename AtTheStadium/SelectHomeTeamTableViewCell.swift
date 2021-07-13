//
//  SelectHomeTeamTableViewCell.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/05/12.
//

import UIKit

class SelectHomeTeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homeTeamName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHomeTeamData(_ homeTeamData: HomeTeamData) {
        self.homeTeamName.text = "\(homeTeamData.homeTeam!)"
        print("DEBUG_PRINT \(String(describing: self.homeTeamName.text))")
    }
    
}
