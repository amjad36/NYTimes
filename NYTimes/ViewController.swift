//
//  ViewController.swift
//  NYTimes
//
//  Created by Amjad Khan on 20/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let reachability = Reachability()!
    var articlesArr: [ArticleModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        getData()
    }
}

extension ViewController: ArticlesNetworkManagerDelegate {
    
    func getData()  {
        if reachability.connection != .none {
            // Utils().showIndicator()
            let articleNetworkManager = ArticlesNetworkManager(withDelegate: self, requestData: nil)
            articleNetworkManager.makeArticlesServiceCall()
        }
        else {
            Logger.debugLog(Constants.ErrorRequest)
        }
    }
    
    func getSuccessResponse(_ response: Any) {
        if let articleModelController = response as? ArticleModelController {
            self.articlesArr = articleModelController.articles
        }
    }
    
    func getErrorResponse(_ response: Any) {
        Logger.debugLog(response)
    }
}
