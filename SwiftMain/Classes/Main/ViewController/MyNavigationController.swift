//
//  MyNavigationController.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/21.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit


class MyNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = UIColor.blue
        navigationBar.backgroundColor = UIColor.white
        /*
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]*/
    }
    
    // 拦截 push 操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: backImageName), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回上一控制器
    @objc private func navigationBack() {
        popViewController(animated: true)
    }
}

extension MyNavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = topViewController else { return .lightContent }
        return topVC.preferredStatusBarStyle
    }
}




enum MyNavigationBarStyle {
    case theme
    case clear
    case white
}

extension UINavigationController
{
    
    func barStyle(_ style: MyNavigationBarStyle) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: navBgImageName), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
            navigationBar.shadowImage = nil
        }
    }
}


/*
 
 private struct AssociatedKeys {
 static var disablePopGesture: Void?
 }
 
 var disablePopGesture: Bool {
 get {
 return objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool ?? false
 }
 set {
 objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
 }
 }
 
 */
