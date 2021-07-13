//
//  CategoryData.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/29.
//

import UIKit
import Firebase

class CategoryData: NSObject {
    var id: String
    var uid :String?
    var category: String?
    
    init(document: QueryDocumentSnapshot) {
        
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.uid = postDic["uid"] as? String
        
        self.category = postDic["category"] as? String
    }
}
