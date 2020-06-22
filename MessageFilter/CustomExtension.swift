//
//  CustomExtension.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/22.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit

extension UIColor {
    class func hex(_ hex: Int) -> UIColor {
        let r = CGFloat((hex & 0xFF0000) >> 16)/255.0
        let g = CGFloat((hex & 0xFF00) >> 8)/255.0
        let b = CGFloat(hex & 0xFF)/255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
