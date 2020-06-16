//
//  DataStoreManager.swift
//  MessageFilterKit
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit

let keyDataGroup = "group.dayer.messageFilter.shareData"


public struct FilterInfo {
    public var messageBody: Bool   // 是否为消息体
    public var regular: Bool       // 是否为正则
    public var rule: String        // 规则
    
    public init(rule: String = "", messageBody: Bool = true, regular: Bool = false) {
        self.messageBody = messageBody
        self.regular = regular
        self.rule = rule
    }
    
    public func saveMessage() -> String {
        if rule.count > 0 {
            return String(messageBody) + "|+|" + String(regular) + "|+|" + rule
        }
        return ""
    }

    static func fetchModel(_ saveMessage: String) -> FilterInfo? {
        if saveMessage.count > 0 {
            let array = saveMessage.components(separatedBy: "|+|")
            if array.count == 3 {
                var filterInfo = FilterInfo()
                filterInfo.messageBody = FilterInfo.getBoolValue(array[0])
                filterInfo.regular = FilterInfo.getBoolValue(array[1])
                filterInfo.rule = array[2]
                return filterInfo
            }
        }
        return nil
    }
    
    
    private static func getBoolValue(_ value: String) -> Bool {
        switch value {
        case "true":
            return true
        default:
            return false
        }
    }
}


public class DataStoreManager: NSObject {

    public class func allData() -> NSDictionary? {
        if let subpaths = FileManager.default.subpaths(atPath: cachePath(fileName: "")) {
            let allData: NSMutableDictionary = [:]
            for fileName in subpaths.sorted() {
                if let array = NSArray(contentsOfFile: cachePath(fileName: fileName)) {
                    var marray = [FilterInfo]()
                    for message in array {
                        if let messageStr: String = message as? String {
                            if messageStr.count > 0 {
                                marray.append(FilterInfo.fetchModel(messageStr)!)
                            }
                        }
                    }
                    allData.setObject(marray, forKey: fileName as NSString)
                }
            }
            return allData
        }
        return nil
    }
    
    
    class func allFilterData() -> Array<FilterInfo>? {
        
        if let subpaths = FileManager.default.subpaths(atPath: cachePath(fileName: "")) {
            var allData = [FilterInfo]()
            for fileName in subpaths.sorted() {
                if let array = NSArray(contentsOfFile: cachePath(fileName: fileName)) {
                    for message in array {
                        if let messageStr: String = message as? String {
                            if messageStr.count > 0 {
                                allData.append(FilterInfo.fetchModel(messageStr)!)
                            }
                        }
                    }
                }
            }
            return allData
        }
        return nil
    }
    
    
    public class func save(filterInfo: FilterInfo) {
        if filterInfo.rule.count > 0 {
            let saveMessage = filterInfo.saveMessage()
            if let caches = NSMutableArray(contentsOfFile: cachePath(fileName: getDateFormatString())) {
                if !caches.contains(saveMessage) {
                    caches.add(filterInfo.saveMessage())
                    caches.write(toFile: cachePath(fileName: getDateFormatString()), atomically: true)
                }
            } else {
                do {
                    try FileManager.default.createDirectory(atPath: cachePath(fileName: ""), withIntermediateDirectories: true, attributes: nil)
                } catch { return }
                let cache: NSArray = [saveMessage]
                cache.write(toFile: cachePath(fileName: getDateFormatString()), atomically: true)
            }
        }
    }
    
    
    public class func delete(filterInfo: FilterInfo, fileName: String) {
        if filterInfo.rule.count > 0 && fileName.count > 0 {
            let saveMessage = filterInfo.saveMessage()
            if let caches = NSMutableArray(contentsOfFile: cachePath(fileName: fileName)) {
                if caches.contains(saveMessage) {
                    caches.remove(saveMessage)
                    if caches.count == 0 {
                        do {
                            try FileManager.default.removeItem(atPath: cachePath(fileName: fileName))
                        } catch {}
                    } else {
                        caches.write(toFile: cachePath(fileName: fileName), atomically: true)
                    }
                }
            }
        }
    }
    
    
    class func cachePath(fileName: String) -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? NSHomeDirectory()).appending("/rules/"+fileName)
    }

    
    class func getDateFormatString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        return dateformatter.string(from: Date())
    }
    
}
