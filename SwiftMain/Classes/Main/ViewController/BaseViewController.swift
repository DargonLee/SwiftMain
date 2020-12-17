//
//  BaseViewController.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/23.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ErrorPopoverRenderer {
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.frame = self.view.bounds
        v.isHidden = true
        v.backgroundColor = UIColor.white
        return v
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.color = UIColor.lightGray
        indicatorView.center = contentView.center
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.globalBackgroundColor()
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        view.addSubview(contentView)
        view.sendSubviewToBack(contentView)
        
        configUI()
    }
    
    public func configUI() {}
    
    
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.theme)
            navi.setNavigationBarHidden(false, animated: true)
        }
    }
    
    public func showLoadingView() {
        contentView.isHidden = false
        self.loadingView.startAnimating()
        view.bringSubviewToFront(contentView)
    }
    
    public func hideLoadingView() {
        contentView.isHidden = true
        self.loadingView.stopAnimating()
        view.sendSubviewToBack(contentView)
    }
    

}

extension BaseViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
