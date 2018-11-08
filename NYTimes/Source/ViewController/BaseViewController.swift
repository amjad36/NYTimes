//
//  BaseViewController.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BaseViewController.handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func handleRefresh() { }

}
