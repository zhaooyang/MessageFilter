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
        
        
        _ = MessageFilterManager.filterMessage(messageBody: "test")
        
        DataStoreManager.allData()
      
        
        
//        let fileManager = FileManager.default
//        fileManager(cont)
//        [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.xxx"]
        
//        fileManager.containerURL(forSecurityApplicationGroupIdentifier: keyDataGroup)
        
        //    [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

    }


}

