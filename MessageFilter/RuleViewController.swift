//
//  RuleViewController.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/16.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit
import MessageFilterKit
class RuleViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITextPasteDelegate  {

    
    @IBOutlet weak var ruleTextFileld: UITextField!
    @IBOutlet weak var senderBtn: UIButton!
    @IBOutlet weak var messageBodyBtn: UIButton!
    @IBOutlet weak var regularBtn: UIButton!
    @IBOutlet weak var allowBtn: UIButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var filterResultTextView: UITextView!
    
    @IBOutlet weak var filterTestBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customNaviBar()
        messageBodyBtn.isSelected = true
        messageBodyBtn.backgroundColor = .blue
        messageTextView.layer.borderColor = UIColor.hex(0xE3E3E3).cgColor
        filterResultTextView.layer.borderColor = UIColor.hex(0xE3E3E3).cgColor
    }

    
    
    
    @IBAction func senderBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = .blue
            messageBodyBtn.isSelected = false
            messageBodyBtn.backgroundColor = .lightGray
        } else {
            sender.backgroundColor = .lightGray
        }
    }
    
    
    @IBAction func messageBodyBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            sender.backgroundColor = .blue
            senderBtn.isSelected = false
            senderBtn.backgroundColor = .lightGray
        } else {
            sender.backgroundColor = .lightGray
        }
    }

    
    @IBAction func regularBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = .blue
        } else {
            sender.backgroundColor = .lightGray
        }
    }
    
    
    @IBAction func allowBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = .blue
        } else {
            sender.backgroundColor = .lightGray
        }
    }
    
    @IBAction func filterTestBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        guard let textFileldInput = ruleTextFileld.text else {
            return
        }
        guard let textViewInput = messageTextView.text else {
            return
        }
        
        if textFileldInput.count == 0 {
            let alertController = UIAlertController(title: nil, message: "请输入过滤规则", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        if textViewInput.count == 0 {
            let alertController = UIAlertController(title: nil, message: "请输入过滤内容", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        
        
        
        let array = MessageFilterManager.getfilterMessageResult(rule: textFileldInput, content: textViewInput, regular: regularBtn.isSelected)
        guard let result = array else { return }
        handleFilterResult(result: result)
        
    }
    
    
    func handleFilterResult(result: [NSTextCheckingResult]) {
        let attrStr = NSMutableAttributedString(string: messageTextView.text)
        for item in result {
//            NSForegroundColorAttributeName
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: item.range)
        }
        attrStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 17), range: NSRange(location: 0, length: attrStr.length))
        filterResultTextView.attributedText = attrStr
        
        
    }
    
    
    func customNaviBar() {
        self.navigationItem.title = "过滤规则"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(saveRule))

    }
    
    @objc private func saveRule() {
        view.endEditing(true)
        guard let rule = ruleTextFileld.text else {
            let alertController = UIAlertController(title: nil, message: "请输入过滤规则", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        if rule.count == 0 {
            let alertController = UIAlertController(title: nil, message: "请输入过滤规则", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }

        var message = "1. 过滤规则: \(rule)\n"
        if messageBodyBtn.isSelected {
            message += "2. 过滤对象: 信息内容\n"
        } else {
            message += "2. 过滤对象: 收件人\n"
        }
        
        if regularBtn.isSelected {
            message += "3. 使用正则表达式进行匹配"
        } else {
            message += "3. 使用包含方式进行匹配"
        }
        let alertController = UIAlertController(title: "过滤规则", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .default) { action in
            var filterInfo = FilterInfo()
            filterInfo.messageBody = self.messageBodyBtn.isSelected
            filterInfo.regular = self.regularBtn.isSelected
            filterInfo.allow = self.allowBtn.isSelected
            filterInfo.rule = rule
            DataStoreManager.save(filterInfo: filterInfo)
        })
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.endEditing(true)
            return false
        }
        return true
    }
    
    
    // MARK: UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.endEditing(true)
            return false
        }
        return true
    }
    
    // MARK: UITextPasteDelegate
    func textPasteConfigurationSupporting(_ textPasteConfigurationSupporting: UITextPasteConfigurationSupporting, shouldAnimatePasteOf attributedString: NSAttributedString, to textRange: UITextRange) -> Bool {
        return false
    }
}
