//
//  Const.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/03/01.
//

import Foundation

struct Const {
    static let PostPath = "posts"
    
    // newMatchDataCreatePathはFirestore内の投稿データ(カテゴリ、セクション、チーム、キックオフの時間等)の保存場所
    static let NewMatchDataCreatePath = "matchCreate"
    
    // stadiumImagePathは、Storage内の画像ファイルの保存場所
    static let StadiumImagePath = "stadiumImages"
    
    static let CategoryPath = "category"
    
    static let SectionPath = "section"
    
    static let HomeTeamPath = "homeTeam"
}
