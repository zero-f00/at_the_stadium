//
//  SelectSectionViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/04/17.
//

import UIKit
import Firebase

class SelectSectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // セクションを格納する配列
    var sectionArray: [SectionData] = []
    // Firestoreのリスナー
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "SelectSectionTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SectionCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            // ログイン済み
            if listener == nil {
                // listener未登録なら、登録してスナップショットを受信する
                let postsRef = Firestore.firestore().collection(Const.SectionPath).order(by: "date", descending: true)
                listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                        return
                    }
                    // 最新の情報を取得するための処理
                    // 取得したdocumentをもとにPostDataを作成し、postArrayの配列にする。
                    self.sectionArray = querySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: document取得 \(document.documentID)")
                        let sectionData = SectionData(document: document)
                        return sectionData
                    }
                    // TableViewの表示を更新する
                    self.tableView.reloadData()
                }
            }
            
        } else {
            if listener != nil {
                // listener登録済みなら削除してpostArrayをクリアする
                listener.remove()
                listener = nil
                sectionArray = []
                
                tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SelectSectionTableViewCell
        cell.setSectionData(sectionArray[indexPath.row])
        
        return cell
    }
}
