//
//  MessageFilterManager.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit


public class MessageFilterManager: NSObject {

    public class func filterMessage(sender: String?, messageBody: String?) -> (Bool, FilterInfo?) {
        let senderInfo = sender ?? ""
        let messageBodyInfo = messageBody ?? ""
        
            guard let filterArray = DataStoreManager.allFilterData() else {
                return (false, nil)
            }
            var match = false
            for filterInfo in filterArray {
                if filterInfo.messageBody {
                    if messageBodyInfo.count > 0 {
                        match = filterResult(message: messageBodyInfo, regular: filterInfo.regular, rule: filterInfo.rule)
                    }
                } else {
                    if senderInfo.count > 0 {
                        match = filterResult(message: senderInfo, regular: filterInfo.regular, rule: filterInfo.rule)
                    }
                }
                if match {
                    return (true, filterInfo)
                }
            }
        return (false, nil)
    }
    
    public class func getfilterMessageResult(rule: String, content: String, regular: Bool) -> [NSTextCheckingResult]? {
        if rule.count == 0 || content.count == 0 {
            return nil
        }
        do {
             let regex = try NSRegularExpression(pattern: rule, options: .caseInsensitive)
            let array = regex.matches(in: content, options: [], range: NSRange(location: 0, length: content.count))
            return array
        } catch  {
            return nil
        }
    }
    
    
    
    private class func filterResult(message: String, regular: Bool, rule: String) -> Bool {
        if regular {
            do {
               let regex = try NSRegularExpression(pattern: rule, options: .caseInsensitive)
                let matchNum = regex.numberOfMatches(in: message, options: [], range: NSRange(location: 0, length: message.count))
                if matchNum == 0 {
                    return false
                }
                return true
            } catch  {
                return false
            }
        } else {
            if message.contains(rule) {
                return true
            } else {
                return false
            }
        }
    }
    
    
}
