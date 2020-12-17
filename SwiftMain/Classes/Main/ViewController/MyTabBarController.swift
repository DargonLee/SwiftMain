//
//  MyTabBarController.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/21.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // let tabbar = UITabBar.appearance()
        // tabbar.tintColor = UIColor.blue
        tabBar.isTranslucent = false
        ///其他的一些配置
        
        addChildViewControllers()

    }
    
    /// 添加子控制器
    private func addChildViewControllers() {
         setChildViewController(UIViewController(), title: "首页", imageName: "home")
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
        // setValue(MyTabBar(), forKey: "tabBar")
    }
    
    /// 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        // 设置 tabbar 文字和图片
        childController.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
        childController.title = title
        // 添加导航控制器为 TabBarController 的子控制器
        addChild(MyNavigationController(rootViewController: childController))
    }

}

extension MyTabBarController
{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else {
            return .lightContent
        }
        return select.preferredStatusBarStyle
    }
}
