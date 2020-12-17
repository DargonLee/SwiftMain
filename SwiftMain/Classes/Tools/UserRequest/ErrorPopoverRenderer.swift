//
//  ErrorPopoverRenderer.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/14.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit
import PKHUD

struct Color {
    let red: Double
    let green: Double
    let blue: Double
    
    init(red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

struct EmptyOptions {
    let message: String
    let imageName: String
    let textColor: UIColor
    
    init(message: String = "Error!", imageName: String = "empty", textColor: UIColor = UIColor.lightText) {
        self.message = message
        self.imageName = imageName
        self.textColor = textColor
    }
}

protocol ErrorPopoverRenderer {
    func presentEmptyView(errorOptions: EmptyOptions)
    func showHUD(with contentType: HUDContentType)
    func showHUDTip(with title: String)
    func hideHUD()
    func showHUDLoading()
    func showHUDLoading(with subTitle: String)
}


extension ErrorPopoverRenderer where Self: UIViewController // 只有继承UIViewController的类才能调添加扩展
{
    
    func presentEmptyView(errorOptions: EmptyOptions)
    {
        let containerView = UIView()
        containerView.frame = view.bounds
        view.addSubview(containerView)
        
        let imageView = UIImageView()
        imageView.height = 100
        imageView.width = 100
        imageView.centerX = containerView.centerX
        imageView.centerY = containerView.centerY
        imageView.image = UIImage(named: errorOptions.imageName)
        containerView.addSubview(imageView)
        
        // 实现
        let labelInfo = UILabel()
        labelInfo.text = errorOptions.message
        labelInfo.textColor = errorOptions.textColor
        labelInfo.sizeToFit()
        labelInfo.centerX = containerView.centerX
        labelInfo.y = imageView.bottom + 10
        containerView.addSubview(labelInfo)
        labelInfo.backgroundColor = UIColor.red
        imageView.backgroundColor = UIColor.yellow
    }
    
    func showHUD(with contentType: HUDContentType)
    {
        HUD.show(contentType)
    }
    
    func showHUDTip(with title: String)
    {
        HUD.dimsBackground = false
        HUD.flash(.label(title), delay: 2.0)
    }
    
    func hideHUD()
    {
        HUD.hide()
    }
    
    func showHUDLoading()
    {
        HUD.show(.progress)
    }
    
    func showHUDLoading(with subTitle: String)
    {
        HUD.show(.labeledProgress(title: "", subtitle: subTitle))
    }
}

/*
class KrakenViewController: UIViewController, ErrorPopoverRenderer {
    func presentLoading(isShowLoading isShow: Bool) {
        
    }
    
    func methodThatHasAnError() {
        presentError(errorOptions: ErrorOptions(
            message: "Oh noes! I didn't get to eat the Human!",
            size: CGSize(width: 1000, height: 200)
        ))
    }
}
*/
