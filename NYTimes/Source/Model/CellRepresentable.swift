//
//  BaseRepresentationModel.swift
//  NYTimes
//
//  Created by Amjad Khan on 21/10/18.
//  Copyright © 2018 Amjad Khan. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
