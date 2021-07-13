//
//  SelectHomeTeamViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/05/12.
//

import UIKit
import Firebase

class SelectHomeTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var selectHomeTeamTableView: UITableView!
    
    
    // ホームチームを格納する入れる
    var homeTeamArray: [HomeTeamData] = []
    // Firestoreのリスナー
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectHomeTeamTableView.delegate = self
        selectHomeTeamTableView.dataSource = self
        
        // カスタムセルを登録する
        let nib = UINib(nibName: "SelectHomeTeamTableViewCell", bundle: nil)
        selectHomeTeamTableView.register(nib, forCellReuseIdentifier: "HomeTeamCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if Auth.auth().currentUser != nil {
            // ログイン済み
            if listener == nil {
                // listener未登録なら、登録してスナップショットを受信する
                let postsRef = Firestore.firestore().collection(Const.HomeTeamPath).order(by: "date", descending: true)
                listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。\(error)")
                        return
                    }
                    // 取得したdocumentをもとにMatchDataを作成し、matchInfoArrayの配列にする。
                    self.homeTeamArray = querySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: document取得 \(document.documentID)")
                        let homeTeamData = HomeTeamData(document: document)
                        return homeTeamData
                    }
                    // TableViewを更新する
                    self.selectHomeTeamTableView.reloadData()
                }
            }
        } else {
            // ログアウト未（またはログアウト済み）
            if listener != nil {
                // listener登録済みなら削除してmatchInfoArrayをクリアする
                listener.remove()
                listener = nil
                homeTeamArray = []
                selectHomeTeamTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeTeamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTeamCell", for: indexPath) as! SelectHomeTeamTableViewCell
        cell.setHomeTeamData(homeTeamArray[indexPath.row])
        
        return cell
    }
}
