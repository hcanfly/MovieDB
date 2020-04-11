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
    private let biographyTextView: UITextView
    private let diedDateLabel: UILabel
    private var posterImageView: AsyncImageView!
    private var actorInfo = Actor(id: 0, name: "", birthday: "", deathday: nil, biography: "", place_of_birth: nil, profile_path: nil)

    func setActorInfo(actorInfo: Actor) {
        self.actorInfo = actorInfo
        if actorInfo.profile_path != nil {
            self.posterImageView!.downloadImage(urlString: imageURLBasePath + actorInfo.profile_path!)
        }

        self.setupInfoViews()
        self.setupConstraints()
        self.setNeedsLayout()
    }

    private func setupInfoViews() {
        self.nameLabel.text = actorInfo.name
        self.nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        self.nameLabel.textColor = .white
        self.nameLabel.adjustsFontSizeToFitWidth = true

        self.birthDateLabel.text = "Born: " + actorInfo.born
        self.birthDateLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.birthDateLabel.textColor = .white
        self.bornPlaceLabel.text = actorInfo.place_of_birth == nil ? "" : " in " + actorInfo.place_of_birth!
        self.bornPlaceLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.bornPlaceLabel.textColor = .white
        if self.actorInfo.deathday != nil {
            self.diedDateLabel.text = "Died: " + actorInfo.died
            self.diedDateLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
            self.diedDateLabel.textColor = .white
        } else {
            self.diedDateLabel.isHidden = true
        }

        self.biographyTextView.textAlignment = .left
        self.biographyTextView.font = UIFont(name: "HelveticaNeue", size: 12.0)
        self.biographyTextView.text = actorInfo.biography ?? ""
        self.biographyTextView.backgroundColor = .clear
        self.biographyTextView.textColor = .white
        self.biographyTextView.isEditable = false
    }

    required init?(coder: NSCoder) {
        
        self.nameLabel = UILabel(frame: CGRect.zero)
        self.birthDateLabel = UILabel(frame: CGRect.zero)
        self.bornPlaceLabel = UILabel(frame: CGRect.zero)
        self.biographyTextView = UITextView(frame: CGRect.zero)
        self.diedDateLabel = UILabel(frame: CGRect.zero)

        super.init(coder: coder)
        self.backgroundColor = .clear

        self.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bornPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.biographyTextView.translatesAutoresizingMaskIntoConstraints = false
        self.diedDateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.biographyTextView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.birthDateLabel)
        self.addSubview(self.bornPlaceLabel)
        self.addSubview(self.diedDateLabel)
        self.posterImageView = AsyncImageView(frame: CGRect.zero, urlString: nil)
        self.posterImageView!.clipsToBounds = true
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.posterImageView)
    }

    private func setupConstraints() {
        let leftEdgeInset:CGFloat = 4
        let edgeInsets = self.safeAreaInsets

        self.bornPlaceLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        NSLayoutConstraint.activate([
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left + leftEdgeInset),
        self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edgeInsets.right),

        self.birthDateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
        self.birthDateLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),

        self.bornPlaceLabel.topAnchor.constraint(equalTo: self.birthDateLabel.topAnchor),
        self.bornPlaceLabel.leadingAnchor.constraint(equalTo: self.birthDateLabel.trailingAnchor),

        self.diedDateLabel.topAnchor.constraint(equalTo: self.birthDateLabel.bottomAnchor, constant: 8),
        self.diedDateLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),

        self.posterImageView!.topAnchor.constraint(equalTo: self.diedDateLabel.bottomAnchor, constant: 10),
        self.posterImageView!.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
        self.posterImageView!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
        self.posterImageView!.widthAnchor.constraint(equalTo: posterImageView!.heightAnchor, multiplier: 0.66666),

        self.biographyTextView.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 8),
        self.biographyTextView.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
        self.biographyTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: edgeInsets.bottom - 40),
        self.biographyTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edgeInsets.right),
        ])
    }
}

