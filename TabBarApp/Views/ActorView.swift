//
//  ActorView.swift
//  TabBarApp
//
//  Created by Gary on 3/3/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit



final class ActorView: UIView {
    private let nameLabel: UILabel
    private let birthDateLabel: UILabel
    private let bornPlaceLabel: UILabel
    private let biographyLabel: UILabel
    private let diedDateLabel: UILabel
    private var poster: AsyncImageView?
    private var actorInfo = Actor(id: 0, name: "", birthday: "", deathday: nil, biography: "", place_of_birth: nil, profile_path: nil)


    override func layoutSubviews() {
        super.layoutSubviews()

        let deathLabelOffset = CGFloat(self.actorInfo.deathday != nil ? 20 : 0)
        if actorInfo.profile_path != nil {
            let desiredImageHeight = CGFloat(self.bounds.height * 0.55)
            self.poster = AsyncImageView(frame: CGRect(x: 0, y: 70 + deathLabelOffset, width: desiredImageHeight * 0.666666, height: desiredImageHeight), urlString: imageURLBasePath + actorInfo.profile_path!)
                self.poster?.clipsToBounds = true
                self.addSubview(self.poster!)
        }

        self.nameLabel.frame = CGRect(x: 0, y: 0, width: 360, height: 20)
        self.birthDateLabel.frame = CGRect(x: 0, y: 20, width: 300, height: 20)
        self.bornPlaceLabel.frame = CGRect(x: 0, y: 40, width: 300, height: 20)
        self.diedDateLabel.frame = CGRect(x: 0, y: 60, width: 300, height: 20)
        self.biographyLabel.frame = CGRect(x: 0, y: CGFloat(60 + deathLabelOffset + self.bounds.height * 0.6 + 60), width: self.bounds.width - 6, height: self.bounds.height * 0.1 - 100)
        self.biographyLabel.sizeToFit()
    }

    convenience init(frame: CGRect, actorInfo: Actor) {
        self.init(frame: frame)

        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false

        self.actorInfo = actorInfo
        self.nameLabel.text = actorInfo.name
        self.nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        self.nameLabel.textColor = .white
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.birthDateLabel.text = "Born: " + actorInfo.born
        self.birthDateLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.birthDateLabel.textColor = .white
        self.bornPlaceLabel.text = actorInfo.place_of_birth ?? ""
        self.bornPlaceLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.bornPlaceLabel.textColor = .white
        if self.actorInfo.deathday != nil {
            self.diedDateLabel.text = "Died: " + actorInfo.died
            self.diedDateLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
            self.diedDateLabel.textColor = .white
        } else {
            self.diedDateLabel.isHidden = true
        }
        self.biographyLabel.textAlignment = .left
        self.biographyLabel.lineBreakMode = .byTruncatingTail
        self.biographyLabel.numberOfLines = 0
        self.biographyLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        self.biographyLabel.text = actorInfo.biography ?? ""
        self.biographyLabel.textColor = .white
        self.addSubview(self.biographyLabel)
    }

    override init(frame: CGRect) {
        self.nameLabel = UILabel(frame: CGRect.zero)
        self.birthDateLabel = UILabel(frame: CGRect.zero)
        self.bornPlaceLabel = UILabel(frame: CGRect.zero)
        self.biographyLabel = UILabel(frame: CGRect.zero)
        self.diedDateLabel = UILabel(frame: CGRect.zero)

        super.init(frame: frame)

        self.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        self.frame = frame
        self.addSubview(self.nameLabel)
        self.addSubview(self.birthDateLabel)
        self.addSubview(self.bornPlaceLabel)
        self.addSubview(self.diedDateLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
