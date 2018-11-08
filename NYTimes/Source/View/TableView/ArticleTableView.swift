//
//  ArticleTableView.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

class ArticleTableView: UITableView {

    // MARK: - Properties

    var arrData: [CellRepresentable]?
    var selectedItemCell: ((CellRepresentable?) -> Void)?

    // MARK: - Initializers

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialize()
    }

    func initialize() {

        //
        // Remove empty cells
        tableFooterView = UIView()

        //
        // Set dynamic cell height

        estimatedRowHeight = 100.0
        rowHeight = UITableView.automaticDimension

        //
        // Assigning delegates
        allowsSelection = true
        dataSource = self
        delegate = self
    }
}

extension ArticleTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = arrData?[indexPath.row].cellInstance(tableView, indexPath: indexPath) ?? UITableViewCell()
        return cell
    }
}

extension ArticleTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedItemCell?(arrData?[indexPath.row])
    }
}
