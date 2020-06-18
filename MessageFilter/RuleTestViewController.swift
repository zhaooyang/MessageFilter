//
//  RuleTestViewController.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/18.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit
import MessageFilterKit
class RuleTestViewController: UIViewController {

    @IBOutlet weak var senderTextFileld: UITextField!
    @IBOutlet weak var filterMessageTextView: UITextView!
    
    @IBOutlet weak var filterActionBtn: UIButton!
    
    @IBOutlet weak var filterResultTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func filterBtnAction(_ sender: UIButton) {
        let senderStr = senderTextFileld.text
        let messageStr = filterMessageTextView.text
        
        print(MessageFilterManager.filterMessage(sender: senderStr, messageBody: messageStr))
        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
