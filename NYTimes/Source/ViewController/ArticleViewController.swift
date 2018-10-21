//
//  ViewController.swift
//  NYTimes
//
//  Created by Amjad Khan on 20/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit
import SVProgressHUD

class ArticleViewController: BaseViewController {
    
    @IBOutlet weak var articleTableView: ArticleTableView!
    let reachability = Reachability()!
    var isRefreshControl: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articleTableView.addSubview(refreshControl)
        getData()
    }
    
    @objc override func handleRefresh() {
        isRefreshControl = true
        getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ArticleDetailViewController {
            if let indexPath = self.articleTableView.indexPathForSelectedRow {
                destination.article = self.articleTableView.arrData?[indexPath.row] as? ArticleModel
            }
        }
    }
}

extension ArticleViewController: ArticlesNetworkManagerDelegate {
    
    func getData()  {
        if reachability.connection != .none {
            if isRefreshControl == false { SVProgressHUD.show() }
            let articleNetworkManager = ArticlesNetworkManager(withDelegate: self, requestData: nil)
            articleNetworkManager.makeArticlesServiceCall()
        }
        else {
            Logger.debugLog(Constants.ErrorRequest)
        }
    }
    
    func getSuccessResponse(_ response: Any) {
        self.refreshControl.endRefreshing()
        SVProgressHUD.dismiss()
        if let articleModelController = response as? ArticleModelController {
            self.articleTableView.arrData = articleModelController.articles
            self.articleTableView.reloadData()
        }
    }
    
    func getErrorResponse(_ response: Any) {
        self.refreshControl.endRefreshing()
        SVProgressHUD.dismiss()
    }
}
