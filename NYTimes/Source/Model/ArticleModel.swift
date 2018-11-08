//
//  ArticleModel.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

class ArticleModel: CellRepresentable, BaseModel {

    // MARK: Model JSON Keys

    struct PropertyKey {
        static let ArticleId = "id"
        static let ArticleTitle = "title"
        static let ArticleType = "type"
        static let Abstract = "abstract"
        static let PublishedDate = "published_date"
        static let ByLine = "byline"
    }

    // MARK: Properties

    var articleId: Int?
    var articleTitle: String?
    var articleType: String?
    var abstract: String?
    var byLine: String?
    var publishedDate: String?

    // MARK: BaseModel Protocol Implementation

    static func createInstanceFromDictionary(_ dictionary: [String: Any]?) -> Any? {
        if dictionary == nil { return nil }

        let instance = ArticleModel()
        instance.setAttributesFromDictionary(dictionary)

        return instance
    }

    func dictionaryRepresentation() -> [String: Any]? {
        var dictionary = [String: String]()

        dictionary[PropertyKey.ArticleId] = String(self.articleId ?? 0)
        dictionary[PropertyKey.ArticleTitle] = self.articleTitle
        dictionary[PropertyKey.ArticleType] = self.articleType
        dictionary[PropertyKey.Abstract] = self.abstract
        dictionary[PropertyKey.PublishedDate] = self.publishedDate
        dictionary[PropertyKey.ByLine] = self.byLine

        return dictionary
    }

    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {

        self.articleId = dictionary?[PropertyKey.ArticleId] as? Int ?? 0
        self.articleTitle = dictionary?[PropertyKey.ArticleTitle] as? String ?? ""
        self.articleType = dictionary?[PropertyKey.ArticleType] as? String ?? ""
        self.abstract = dictionary?[PropertyKey.Abstract] as? String ?? ""
        self.publishedDate = dictionary?[PropertyKey.PublishedDate] as? String ?? ""
        self.byLine = dictionary?[PropertyKey.ByLine] as? String ?? ""
    }

    // MARK: CellRepresentable Protocol Implementation

    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        cell?.configureCell(article: self)
        return cell ?? UITableViewCell()
    }

}
