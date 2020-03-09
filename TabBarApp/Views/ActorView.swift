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
    private var posterImageView: AsyncImageView!
    private var actorInfo = Actor(id: 0, name: "", birthday: "", deathday: nil, biography: "", place_of_birth: nil, profile_path: nil)



    private func setupConstraints() {
        let leftEdgeInset:CGFloat = 4
        let edgeInsets = self.safeAreaInsets

        self.bornPlaceLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        NSLayoutConstraint.activate([
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top + 10),
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left + leftEdgeInset),
        self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edgeInsets.right),

        self.birthDateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
        self.birthDateLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),

        self.bornPlaceLabel.topAnchor.constraint(equalTo: self.birthDateLabel.topAnchor),
        self.bornPlaceLabel.leadingAnchor.constraint(equalTo: self.birthDateLabel.trailingAnchor),
        self.bornPlaceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edgeInsets.right),

        self.diedDateLabel.topAnchor.constraint(equalTo: self.birthDateLabel.bottomAnchor, constant: 8),
        self.diedDateLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),

        self.posterImageView!.topAnchor.constraint(equalTo: self.birthDateLabel.bottomAnchor, constant: 10),
        self.posterImageView!.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
        self.posterImageView!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
        self.posterImageView!.widthAnchor.constraint(equalTo: posterImageView!.heightAnchor, multiplier: 0.66666),

        self.biographyLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 8),
        self.biographyLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
        //self.biographyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: edgeInsets.bottom),
        self.biographyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edgeInsets.right),
        ])
    }

    func setActorInfo(actorInfo: Actor) {
        self.actorInfo = actorInfo
        if actorInfo.profile_path != nil {
            self.posterImageView!.clipsToBounds = true
            self.posterImageView!.downloadImage(urlString: imageURLBasePath + actorInfo.profile_path!)
        }

        updateViewsInfo()
        self.setNeedsLayout()
    }

    private func updateViewsInfo() {
        self.nameLabel.text = actorInfo.name
        self.nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        self.nameLabel.textColor = .white
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false

        self.birthDateLabel.text = "Born: " + actorInfo.born
        self.birthDateLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.birthDateLabel.textColor = .white
        self.birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bornPlaceLabel.text = actorInfo.place_of_birth == nil ? "" : " in " + actorInfo.place_of_birth!
        self.bornPlaceLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.bornPlaceLabel.textColor = .white
        self.bornPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        if self.actorInfo.deathday != nil {
            self.diedDateLabel.text = "Died: " + actorInfo.died
            self.diedDateLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
            self.diedDateLabel.textColor = .white
            self.diedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        } else {
            self.diedDateLabel.isHidden = true
        }

        self.biographyLabel.textAlignment = .left
        self.biographyLabel.lineBreakMode = .byTruncatingTail
        self.biographyLabel.numberOfLines = 0
        self.biographyLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        self.biographyLabel.text = actorInfo.biography ?? ""
        self.biographyLabel.textColor = .white
        self.biographyLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        
        self.nameLabel = UILabel(frame: CGRect.zero)
        self.birthDateLabel = UILabel(frame: CGRect.zero)
        self.bornPlaceLabel = UILabel(frame: CGRect.zero)
        self.biographyLabel = UILabel(frame: CGRect.zero)
        self.diedDateLabel = UILabel(frame: CGRect.zero)

        super.init(coder: coder)
        self.backgroundColor = .clear

        self.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bornPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.diedDateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.biographyLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.birthDateLabel)
        self.addSubview(self.bornPlaceLabel)
        self.addSubview(self.diedDateLabel)
        self.posterImageView = AsyncImageView(frame: CGRect.zero, urlString: nil)
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.posterImageView)

        self.setupConstraints()
    }
}

