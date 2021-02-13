//
//  CastTableViewCell.swift
//  TabBarApp
//
//  Created by Gary on 3/3/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class CastTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CastCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init( style: .value1, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .systemPink
        self.textLabel?.textColor = .white
        self.textLabel?.font = UIFont(name: baseFontName, size: 14.0)
        self.detailTextLabel?.textColor = .white
        self.detailTextLabel?.font = UIFont(name: baseFontName, size: 14.0)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
