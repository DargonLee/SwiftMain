//
//  ViewController.swift
//  SwiftMain
//
//  Created by Harlan on 2018/12/26.
//  Copyright © 2018 Harlan. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, UIViewControllerTransitioningDelegate
{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.clear)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
//        let secondViewController = TableViewController()
//        let presentationController = CustomPresentationController(with: secondViewController, presentingViewController: self)
//        secondViewController.transitioningDelegate = presentationController
//        present(secondViewController, animated: true, completion: nil)
        
//        let secondViewController = TableViewController()
//        secondViewController.modalPresentationStyle = .fullScreen
//        secondViewController.transitioningDelegate = self
//        present(secondViewController, animated: true, completion: nil)
//        presentEmptyView(errorOptions: EmptyOptions(
//            message: "亲，您还没有订单哦"
//        ))
//        showHUD(with: "测试hud")
//        showHUD(with: .label("xxxx"))
//        showLoading()
        UNoticeBar(config: UNoticeBarConfig(title: "主人,检测到您正在使用移动数据")).show(duration: 2)
        
        // 网络请求测试
//        showLoadingView()
//        NetworkTool.loadHomeNewsTitleData { (titles) in
//            print("------")
//            print(titles)
//        }
//        DispatchQueue.main.after(3.0) {
//            self.hideLoadingView()
//            self.hideHUD()
//        }
//        self.presentError(errorOptions: ErrorOptions(
//            message: "Oh noes! I didn't get to eat the Human!",
//            size: CGSize(width: 1000, height: 200)
//        ))
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return CrossDissolveTransitionAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return CrossDissolveTransitionAnimator()
    }

}

