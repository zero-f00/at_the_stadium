//
//  AddMatchDataTableViewCell.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/06/30.
//

import UIKit

class AddMatchDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMatchData(_ matchData: MatchData) {
        // キックオフ時刻の表示
        self.dateLabel.text = ""
        if let date = matchData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateAndTime = date.formattedDateWith(style: .longDateAndTime)
            self.dateLabel.text = "KICKOFF \(dateAndTime)"
        }
        
        //  一旦、nilで許容（項目の実装ができて入れられるようになったら修正）
        
        // カテゴリの表示
        self.categoryLabel.text = "\(String(describing: matchData.category))"
        
        // セクションの表示
        self.sectionLabel.text = "\(String(describing: matchData.section))"
        
        // 対戦カードの表示
        self.homeTeamLabel.text = "\(String(describing: matchData.homeTeamName))"
        self.awayTeamLabel.text = "\(String(describing: matchData.awayTeamName))"
        
        // スタジアム名の表示
        self.stadiumLabel.text = "\(String(describing: matchData.stadiumName))"
    }
    
}
