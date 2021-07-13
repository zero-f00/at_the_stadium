//
//  SectionData.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/04/17.
//

import UIKit
import Firebase

class SectionData: NSObject {
    var id: String
    var uid :String?
    var section: String?
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.uid = postDic["uid"] as? String
        
        self.section = postDic["section"] as? String
    }
}
