//
//  TableViewController.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/23.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit

class TableViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: view.bounds.size.width, height: 350)
        let btn = UIButton(type: .contactAdd)
        btn.center = view.center
        btn.addTarget(self, action: #selector(diss), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func diss() {
        dismiss(animated: true, completion: nil)
    }

}
