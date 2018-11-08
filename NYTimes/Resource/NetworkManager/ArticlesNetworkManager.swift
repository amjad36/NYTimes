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
        do {
            let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
            let responseModel = ArticleModelController.createInstanceFromData(data) as Any
            self.delegate?.getSuccessResponse(responseModel)
        } catch {
            print("error = \(error.localizedDescription)")
        }
    }

    func getErrorResponse(_ response: Any) {
        self.delegate?.getErrorResponse(response)
    }

}
