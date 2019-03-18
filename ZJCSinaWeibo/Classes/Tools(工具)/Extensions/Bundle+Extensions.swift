//
//  Bundle+Extensions.swift
//  SwiftDemo
//
//  Created by 小川 on 2017/9/13.
//  Copyright © 2017年 sposter.net. All rights reserved.
//

import Foundation

extension Bundle {
    
    
    /// 返回命名空间字符串
//    func nameSpace() -> String {
//        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
//    }
    
    /// 计算型属性类似于函数,没有参数,有返回值
    var nameSpace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
