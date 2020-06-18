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
        
        
//        let match = MessageFilterManager.filterMessage(sender: "test", messageBody: " This")
//        print(match)
        
//        _ = DataStoreManager.allData()

//        DataStoreManager.save(filterInfo: FilterInfo(rule: "This$", messageBody: true, regular: true))
        
        
        
        // com.zdayer.messageFilter
        
//        let fileManager = FileManager.default
//        fileManager(cont)
//        [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.xxx"]
        
//        fileManager.containerURL(forSecurityApplicationGroupIdentifier: keyDataGroup)
        
        //    [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        //获取分组的共享目录
//        NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.cn.vimfung.ShareExtensionDemo"];
//        NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"demo.txt"];
//
//        //写入文件
//        [@"abc" writeToURL:fileURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
//
//        //读取文件
//        NSString *str = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"str = %@", str);
//
        
        
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
        
        
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }
    
    @objc func tapAction() {
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.zdayer.messageFilter.shareData")
        let fileUrl = url?.appendingPathComponent("dome.txt")
        guard let fileURL = fileUrl else {
            return
        }
//        do {
//            let str = try String(contentsOf: fileURL, encoding: .utf8)
//            print("str = \(str)")
//        } catch  {
//            print("_______")
//        }
//
        
        let array = NSArray(contentsOf: fileURL)
        print("array =\(array as Any)")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let fileManager = FileManager.default
        
        let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.zdayer.messageFilter.shareData")
//        let fileUrl = url?.appendingPathComponent("dome.plist")
        let fileUrl = url?.appendingPathComponent("dome")
        guard let fileURL = fileUrl else {
            return
        }
    
        do {
            try fileManager.createDirectory(at: fileURL, withIntermediateDirectories: true, attributes: nil)
            print(fileURL)
        } catch  {
            print("false")
        }
        
        
        print(fileManager.subpaths(atPath: url!.absoluteString) as Any)
        
//        do {
//            let array : NSArray = ["abc", "bcd"]
//            print(array.write(to: fileURL, atomically: true))
//            try ["abc", ".write(to: fileURL, atomically: true, encoding: .utf8)
//        } catch {
//            return
//        }
        
        
        //        if let subpaths = FileManager.default.subpaths(atPath: cachePath(fileName: "")) {
        
//        do {
//            try FileManager.default.createDirectory(at: fileUrl!, withIntermediateDirectories: true, attributes: nil)
//        } catch  {
//            print("++++++=")
//        }
//        FileManager.default
//        let sub = FileManager.default.subpaths(atPath: url!.absoluteString)
//        print("sub = \(sub as Any)")
//
        do {
            let subd = try FileManager.default.subpathsOfDirectory(atPath: url!.absoluteString)
            print("subd = \(subd as Any)")
        } catch  {
            print("====")
        }
//

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

