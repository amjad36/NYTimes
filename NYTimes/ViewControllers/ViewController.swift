//
//  ViewController.swift
//  NYTimes
//
//  Created by Amjad Khan on 20/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var articleTableView: ArticleTableView!
    let reachability = Reachability()!
    
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
            self.articleTableView.arrData = articleModelController.articles
            self.articleTableView.reloadData()
//            performUIUpdatesOnMain {
//                self.articleTableView.reloadData()
//            }
        }
    }
    
    func getErrorResponse(_ response: Any) {
        Logger.debugLog(response)
    }
}
