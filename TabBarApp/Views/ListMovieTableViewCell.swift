//
//  ListMovieTableViewCell.swift
//  TabBarApp
//
//  Created by Gary on 3/3/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class ListMovieTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ListMovieCell"

    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: frame.height * 0.666666 + 10, y: 0, width: 200, height: 20))

        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: frame.height * 0.666666 + 10, y: 14, width: frame.width - (frame.height * 0.666666 + 10) - 80, height: 80))

        label.font = UIFont(name: "HelveticaNeue", size: 12.0)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0

        return label
    }()


    func addPoster(posterPath: String) {
        let poster = AsyncImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height * 0.666666, height: contentView.frame.height - 10), urlString: imageURLBasePath + posterPath)

        poster.clipsToBounds = true

        self.addSubview(poster)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.addSubview((self.nameLabel))
        self.addSubview(self.descriptionLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))

        let padding = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: padding)

        let desiredImageHeight = CGFloat(contentView.frame.height * 0.666666)
        self.nameLabel.frame = CGRect(x: desiredImageHeight + 22, y: 0, width: 200, height: 20)
        self.descriptionLabel.frame = CGRect(x: desiredImageHeight + 22, y: 14, width: contentView.frame.width - (desiredImageHeight + 10), height: contentView.frame.height - 20)
    }


    override func awakeFromNib() {
        super.awakeFromNib()

        //doLayout()
    }
}
