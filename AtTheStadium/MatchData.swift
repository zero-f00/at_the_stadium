//
//  MatchData.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/01.
//

import UIKit
import Firebase

class MatchData: NSObject {
    var id: String
    var category: String?
    var section: String?
    var homeTeamName: String?
    var awayTeamName: String?
    var stadiumName: String?
    var date: Date?

    init(document: QueryDocumentSnapshot) {
        
        self.id = document.documentID
        
        let postDic = document.data()
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        self.category = postDic["category"] as? String

        self.section = postDic["section"] as? String

        self.homeTeamName = postDic["homeTeamName"] as? String
        
        self.awayTeamName = postDic["awayTeamName"] as? String
        
        self.stadiumName = postDic["stadiumName"] as? String
    }
}
