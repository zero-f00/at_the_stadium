//
//  BaseHomeViewController.swift
//  AtTheStadium
//
//  Created by Yuto Masamura on 2021/02/04.
//

import UIKit

class BaseHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        let postVC = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        self.present(postVC, animated: true, completion: nil)
    }
    
    
}
