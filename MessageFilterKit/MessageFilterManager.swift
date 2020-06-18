//
//  MessageFilterManager.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit


enum FilterType {
    case None
    case All
    case Sender
    case Message
}



public class MessageFilterManager: NSObject {

    public class func filterMessage(sender: String?, messageBody: String?) -> Bool {
        var type: FilterType = .None
        var senderInfo = ""
        var messageBodyInfo = ""
        if let senderStr = sender, let messageBodyStr = messageBody {
            if senderStr.count > 0 && messageBodyStr.count > 0 {
                senderInfo = senderStr
                messageBodyInfo = messageBodyStr
                type = .All
            }
        } else if let senderStr = sender {
            if senderStr.count > 0 {
                senderInfo = senderStr
                type = .Sender
            }
        } else if let messageBodyStr = messageBody {
            if messageBodyStr.count > 0 {
                messageBodyInfo = messageBodyStr
                type = .Message
            }
        }
        
            guard let filterArray = DataStoreManager.allFilterData() else {
                return false
            }
            var match = false
            for filterInfo in filterArray {
                switch type {
                case .All:
                    if filterInfo.messageBody {
                        match = filterResult(message: messageBodyInfo, regular: filterInfo.regular, rule: filterInfo.rule)
                    } else {
                        match = filterResult(message: senderInfo, regular: filterInfo.regular, rule: filterInfo.rule)
                    }
                    break
                case .Sender:
                    if filterInfo.messageBody {
                        break
                    }
                    match = filterResult(message: senderInfo, regular: filterInfo.regular, rule: filterInfo.rule)
                case .Message:
                    if filterInfo.messageBody {
                        match = filterResult(message: messageBodyInfo, regular: filterInfo.regular, rule: filterInfo.rule)
                    }
                    break
                case .None:
                    break
                }
                if match {
                    return true
                }
            }
        return false
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
