//
//  ArticleDetailViewController.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblArticleAbstract: UILabel!
    @IBOutlet weak var lblPublishedDate: UILabel!
    @IBOutlet weak var lblPublishedBy: UILabel!

    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        //
        // Set details data
        self.lblArticleAbstract.text = article?.abstract
        self.lblArticleTitle.text = article?.title
        self.lblPublishedBy.text = article?.byLine
        self.lblPublishedDate.text = "📅" + " " + (article?.publishedDate ?? "")
    }

}
