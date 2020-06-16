//
//  ViewController.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit
import MessageFilterKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let match = MessageFilterManager.filterMessage(sender: "test", messageBody: " This")
        print(match)
        
//        _ = DataStoreManager.allData()

        DataStoreManager.save(filterInfo: FilterInfo(rule: "This$", messageBody: true, regular: true))
        
        
        
        
        
//        let fileManager = FileManager.default
//        fileManager(cont)
//        [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.xxx"]
        
//        fileManager.containerURL(forSecurityApplicationGroupIdentifier: keyDataGroup)
        
        //    [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    
    @IBAction func historyAction(_ sender: Any) {
        let historyTVC = HistoryTableViewController()
        navigationController?.pushViewController(historyTVC, animated: true)
    }
    
//    
//    @IBAction func addAction(_ sender: Any) {
//        let ruleVC = RuleViewController()
//        navigationController?.pushViewController(ruleVC, animated: true)
//    }
}

