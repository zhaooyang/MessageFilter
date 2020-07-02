//
//  ViewController.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit
import MessageFilterKit


//let keyDataGroup = "group.zdayer.messageFilter.shareData"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
    }
  
    
    @IBAction func historyAction(_ sender: Any) {
        let historyTVC = HistoryTableViewController()
        navigationController?.pushViewController(historyTVC, animated: true)
    }

}
