//
//  HomeTeamData.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/05/12.
//

import UIKit
import Firebase

class HomeTeamData: NSObject {
    var id: String
    var uid :String?
    var homeTeam: String?
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()
        
        self.uid = postDic["uid"] as? String
        
        self.homeTeam = postDic["homeTeam"] as? String
    }
}
