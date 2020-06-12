//
//  MessageFilterManager.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit




public class MessageFilterManager: NSObject {

    public class func filterMessage(messageBody: String) -> Bool {
        print("messageBody: \(messageBody)")
        return true
    }
}
