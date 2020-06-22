//
//  DataStoreManager.swift
//  MessageFilterKit
//
//  Created by zhaoyang on 2020/6/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit

let keyDataGroup = "group.zdayer.messageFilter.shareData"
let keyCacheDate = "CacheDate"

public struct FilterInfo {
    public var messageBody: Bool   // 是否为消息体
    public var regular: Bool       // 是否为正则
    public var rule: String        // 规则
    public var allow: Bool         // 白名单
    
    public init(rule: String = "", messageBody: Bool = true, regular: Bool = false, allow: Bool = false) {
        self.messageBody = messageBody
        self.regular = regular
        self.rule = rule
        self.allow = allow
    }
    
    public func saveMessage() -> String {
        if rule.count > 0 {
            return String(messageBody) + "|+|" + String(regular) + "|+|" + String(allow) + "|+|" + rule
        }
        return ""
    }

    static func fetchModel(_ saveMessage: String) -> FilterInfo? {
        if saveMessage.count > 0 {
            let array = saveMessage.components(separatedBy: "|+|")
            if array.count == 4 {
                var filterInfo = FilterInfo()
                filterInfo.messageBody = FilterInfo.getBoolValue(array[0])
                filterInfo.regular = FilterInfo.getBoolValue(array[1])
                filterInfo.allow = FilterInfo.getBoolValue(array[2])
                filterInfo.rule = array[3]
                
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
        if let cacheDate = NSArray(contentsOf: cachePath(fileName: keyCacheDate)) {
            let allData: NSMutableDictionary = [:]
            for fileName in cacheDate {
                if let array = NSArray(contentsOf: cachePath(fileName: fileName as! String)) {
                    var marray = [FilterInfo]()
                    for message in array {
                        if let messageStr: String = message as? String {
                            if messageStr.count > 0 {
                                marray.append(FilterInfo.fetchModel(messageStr)!)
                            }
                        }
                    }
                    allData.setObject(marray, forKey: fileName as! NSString)
                }
            }
            return allData
        }
        return nil
    }
    
    
    class func allFilterData() -> (Array<FilterInfo>?, Array<FilterInfo>?) {
        if let cacheDate = NSArray(contentsOf: cachePath(fileName: keyCacheDate)) {
            var allAllowData = [FilterInfo]()
            var allData = [FilterInfo]()
            for fileName in cacheDate {
                if let array = NSArray(contentsOf: cachePath(fileName: fileName as! String)) {
                    for message in array {
                        if let messageStr: String = message as? String {
                            if messageStr.count > 0 {
                                let filterInfo = FilterInfo.fetchModel(messageStr)!
                                if filterInfo.allow {
                                    allAllowData.append(filterInfo)
                                } else {
                                    allData.append(filterInfo)
                                }
                            }
                        }
                    }
                }
            }
            return (allAllowData, allData)
        }
        return (nil, nil)
    }
    
    
    public class func save(filterInfo: FilterInfo) {
        if filterInfo.rule.count > 0 {
            let saveMessage = filterInfo.saveMessage()
            if let caches = NSMutableArray(contentsOf: cachePath(fileName: getDateFormatString())) {
                if !caches.contains(saveMessage) {
                    caches.add(filterInfo.saveMessage())
                    caches.write(to: cachePath(fileName: getDateFormatString()), atomically: true)
                }
            } else {
                let cache: NSArray = [saveMessage]
                if let cacheDate = NSMutableArray(contentsOf: cachePath(fileName: keyCacheDate)) {
                    if !cacheDate.contains(getDateFormatString()) {
                        cacheDate.add(getDateFormatString())
                        cacheDate.write(to: cachePath(fileName: keyCacheDate), atomically: true)
                    }
                } else {
                    let cacheDate: NSArray = [getDateFormatString()]
                    cacheDate.write(to: cachePath(fileName: keyCacheDate), atomically: true)
                }
                cache.write(to: cachePath(fileName: getDateFormatString()), atomically: true)
            }
        }
    }
    
    
    public class func delete(filterInfo: FilterInfo, fileName: String) {
        if filterInfo.rule.count > 0 && fileName.count > 0 {
            let saveMessage = filterInfo.saveMessage()
            if let caches = NSMutableArray(contentsOf: cachePath(fileName: fileName)) {
                if caches.contains(saveMessage) {
                    caches.remove(saveMessage)
                    if caches.count == 0 {
                        do {
                            try FileManager.default.removeItem(at: cachePath(fileName: fileName))
                            if let cacheDate = NSMutableArray(contentsOf: cachePath(fileName: keyCacheDate)) {
                                if cacheDate.contains(fileName) {
                                    cacheDate.remove(fileName)
                                    cacheDate.write(to: cachePath(fileName: keyCacheDate), atomically: true)
                                }
                            }
                        } catch {}
                    } else {
                        caches.write(to: cachePath(fileName: fileName), atomically: true)
                    }
                }
            }
        }
    }
    
    
    class func cachePath(fileName: String) -> URL {
        guard var path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: keyDataGroup) else {
            return URL(string: "")!
        }
        path.appendPathComponent(fileName+".txt")
        return path
    }

    
    class func getDateFormatString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        return dateformatter.string(from: Date())
    }
    
}
