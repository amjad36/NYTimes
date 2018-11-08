//
//  ArticleModelController.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

class ArticleModelController: BaseModel {

    // MARK: Model JSON Keys

    struct PropertyKey {
        static let Results = "results"
    }

    // MARK: Properties

    var articles: [ArticleModel]?

    // MARK: BaseModel Protocol Implementation

    static func createInstanceFromDictionary(_ dictionary: [String: Any]?) -> Any? {

        if dictionary == nil { return nil }

        let instance = ArticleModelController()
        instance.setAttributesFromDictionary(dictionary)

        return instance
    }

    func dictionaryRepresentation() -> [String: Any]? {
        return nil
    }

    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        if let mostViewedArticles = dictionary?[PropertyKey.Results] as? [Any] {
            articles = listFromRawArray(mostViewedArticles)
        }
    }

}
