//
//  SelectCategoryViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/24.
//

import UIKit
import Firebase

class SelectCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var selectCategoryTableView: UITableView!
    
    var categoryArray: [CategoryData] = []
    
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectCategoryTableView.delegate = self
        selectCategoryTableView.dataSource = self
        
        let nib = UINib(nibName: "SelectCategoryTableViewCell", bundle: nil)
        selectCategoryTableView.register(nib, forCellReuseIdentifier: "CategoryCell")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            // ログイン済み
            if listener == nil {
                let postsRef = Firestore.firestore().collection(Const.CategoryPath).order(by: "date", descending: true)
                listener = postsRef.addSnapshotListener() { (QuerySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                        return
                    }
                    self.categoryArray = QuerySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: document取得 \(document.documentID)")
                        let categoryData = CategoryData(document: document)
                        
                        print("DEBUG_PRINT: カテゴリの配列確認 \(categoryData)")
                        return categoryData
                    }
                    self.selectCategoryTableView.reloadData()
                }
            }
        } else {
            if listener != nil {
                listener.remove()
                listener = nil
                categoryArray = []
                
                selectCategoryTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SelectCategoryTableViewCell
        cell.setCategoryData(categoryArray[indexPath.row])
        
        return cell
    }
}
