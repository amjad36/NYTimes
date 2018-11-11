//
//  ArticlesNetworkManager.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

protocol ArticlesNetworkManagerDelegate: class {
    func getSuccessResponse(_ response: Any)
    func getErrorResponse(_ response: Any)
}

class ArticlesNetworkManager: NetworkDelegate {

    weak var delegate: ArticlesNetworkManagerDelegate?
    var jsonData: Data?

    init(withDelegate delegate: ArticlesNetworkManagerDelegate, requestData: Data?) {
        self.delegate = delegate
        self.jsonData = requestData
    }

    func makeArticlesServiceCall() {
        let networkManager = NetworkManager()
        networkManager.createRequest("7.json", httpMethod: .get, body: nil, accessToken: Constants.API_Key, networkDelegate: self)
    }

    func getSuccessResponse(_ response: Any) {
        /*
        guard let dic = response as? [String: Any] else {
            return
        }
        let responseModel = ArticleModelController.createInstanceFromDictionary(dic) as Any
        self.delegate?.getSuccessResponse(responseModel)
         */
        guard let resData = response as? Data else {
            return
        }
        if let articleController = try? JSONDecoder().decode(ArticleController.self, from: resData) {
            //It will automatically map the json keys to properties name as defined
            //in ArticleController class and respective CodingKeys enum.
            print(articleController.articles.count)
            self.delegate?.getSuccessResponse(articleController)
        }
    }

    func getErrorResponse(_ response: Any) {
        self.delegate?.getErrorResponse(response)
    }

}
