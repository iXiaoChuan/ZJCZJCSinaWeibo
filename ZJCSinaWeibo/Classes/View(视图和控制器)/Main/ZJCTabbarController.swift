//
//  ZJCTabbarViewController.swift
//  ZJCSinaWeibo
//
//  Created by 小川 on 2017/9/14.
//  Copyright © 2017年 sposter.net. All rights reserved.
//

import UIKit


// 主控制器
class ZJCTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置子控制器
        setupChildControllers()
        setupComposeButton() 
    }
    
    // MARK: 私有控件
    // 中间按钮
    fileprivate lazy var composeButton : UIButton = UIButton()
}



// extension类似于Objective-C中的分类,在 Swift 中还可以用来切分代码块
// - 可以把相近功能的函数,放在一个 extension 中
// - 便于代码维护
// 注意: 和Objective-C的分类一样, extension 中不能定义属性

// MARK: - 设置界面
extension ZJCTabbarController {
    
    fileprivate func setupComposeButton() {
        composeButton.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: UIControlState.normal)
        composeButton.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        composeButton.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: UIControlState.normal)
        composeButton.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        tabBar.addSubview(composeButton)
        
        // 计算按钮的宽度
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count - 1
        
        // CGRectInset 正数向内缩进,负数向外缩进
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        print("撰写按钮的宽度 \(composeButton.bounds.width)")
    }
    
    // 设置所有的子控制器
    fileprivate func setupChildControllers() {
        let  array = [
            [ "clsName":"ZJCHomeViewController" , "title":"首页", "imageName":"home"],
            [ "clsName":"ZJCMessageViewController" , "title":"消息", "imageName":"message_center"],
            [ "clsName":"UIViewController" ],
            [ "clsName":"ZJCDiscoveryViewController" , "title":"发现", "imageName":"discover"],
            [ "clsName":"ZJCProfileViewController" , "title":"我的", "imageName":"profile"],
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    
    // 使用字典创建一个子控制器
    //
    // - parameter dictionary: 信息字典 [clsname , title , imageName]
    //
    // - return : 子控制器
    //
    func controller(dict: [String : String]) -> UIViewController {
        
        // 1.获取字典
        guard let clsName = dict["clsName"],
        let title = dict["title"],
        let imageName = dict["imageName"],
        let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type
            else {
            return UIViewController()
        }
        
        // 2.创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        // 3.设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 4.设置tabbar
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState.normal)
        
        let nav = ZJCNavigationController(rootViewController: vc)
        return nav
        
    }
    
}
