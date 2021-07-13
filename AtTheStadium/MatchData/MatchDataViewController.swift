//
//  MatchDataViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/06/30.
//

import UIKit
import Firebase

class MatchDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var matchDataTableView: UITableView!
    
    var matchInfoArray: [MatchData] = []
//    var matchInfo: MatchData?
    
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchDataTableView.delegate = self
        matchDataTableView.dataSource = self
        
        // カスタムセルを登録する
        let nib = UINib(nibName: "AddMatchDataTableViewCell", bundle: nil)
        matchDataTableView.register(nib, forCellReuseIdentifier: "MatchDataCell")
        
        // セルの高さ
        matchDataTableView.rowHeight = 245.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            // ログイン済み
            if listener == nil {
                let postsRef = Firestore.firestore().collection(Const.NewMatchDataCreatePath).order(by: "date", descending: true)
                listener = postsRef.addSnapshotListener() { (QuerySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。\(error)")
                        return
                    }
                    self.matchInfoArray = QuerySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: document取得 \(document.documentID)")
                        let matchData = MatchData(document: document)
                        return matchData
                    }
                    self.matchDataTableView.reloadData()
                }
            }
        } else {
            if listener != nil {
                listener.remove()
                listener = nil
                matchInfoArray = []
                
                matchDataTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDataCell", for: indexPath) as! AddMatchDataTableViewCell
        cell.setMatchData(matchInfoArray[indexPath.row])
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        matchInfo = matchInfoArray[indexPath.row]
//
//        // セルがタップされた時のアクション
//        performSegue(withIdentifier: "cellSegue",sender: nil)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let AddMatchDetailViewController = segue.destination as! addMatchDetailViewController
//        AddMatchDetailViewController.matchInfoDetail = matchInfo
//    }
    
}
