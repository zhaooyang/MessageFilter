//
//  DataStoreManager.swift
//  MessageFilterKit
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit

let keyDataGroup = "group.dayer.messageFilter.shareData"


struct FilterInfo {
    var messageBody: Bool
    var regular: Bool
    var rule: String
    
//    func saveMessage() -> String {
//        
//        
//        
//    }
//
    
    
    
}


public class DataStoreManager: NSObject {

    public class func allData() {
        print(keyDataGroup)
    }
}
