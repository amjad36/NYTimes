//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

enum HttpHeaders: String {
    case api_key = "api-key"
    case contentType = "Content-Type"
    case application_json = "application/json"
    case authorization = "Authorization"
}

protocol NetworkDelegate: class {
    func getSuccessResponse(_ response: Any)
    func getErrorResponse(_ response: Any)
}

class NetworkManager: NSObject {

    func createRequest(_ url: String, httpMethod: HttpMethods, body: Data?, accessToken: String, networkDelegate: NetworkDelegate) {

        let requestUrl = URL(string: Constants.Url + url)
        var request = URLRequest(url: requestUrl!)

        request.httpMethod = httpMethod.rawValue
        request.setValue(accessToken, forHTTPHeaderField: HttpHeaders.api_key.rawValue)

        if httpMethod == HttpMethods.post {
            request.httpBody = body
        }

        let dic = [Constants.Error: Constants.ErrorRequest]

        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
            guard let resData = data, response != nil, error == nil else {
                performUIUpdatesOnMain {
                    networkDelegate.getErrorResponse(dic)
                }
                return
            }
            /*
            do {
                let json = try JSONSerialization.jsonObject(with: resData, options: [])
                performUIUpdatesOnMain {
                    networkDelegate.getSuccessResponse(json)
                }
            } catch {
                performUIUpdatesOnMain {
                    networkDelegate.getSuccessResponse(dic)
                }
            }
             */
            performUIUpdatesOnMain {
                networkDelegate.getSuccessResponse(resData)
            }

            }.resume()
    }
}
