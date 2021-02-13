//
//  MovieView.swift
//  TabBarApp
//
//  Created by Gary on 3/1/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class MovieView: UIView {
    private let nameLabel: UILabel
    private let runningTimeLabel: UILabel
    private let ratingsLabel: UILabel
    private let descriptionTextView: UITextView
    private let voterCountLabel: UILabel
    private var poster: AsyncImageView!
    var movieInfo: Movie! {
        didSet {
            self.loadInfo()
            setNeedsLayout()
        }
    }


    override init(frame: CGRect) {
        self.nameLabel = UILabel(frame: CGRect.zero)
        self.descriptionTextView = UITextView(frame: CGRect.zero)
        self.runningTimeLabel = UILabel(frame: CGRect.zero)
        self.ratingsLabel = UILabel(frame: CGRect.zero)
        self.voterCountLabel = UILabel(frame: CGRect.zero)
        self.poster = AsyncImageView(frame: CGRect.zero, urlString: nil)

        super.init(frame: frame)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.runningTimeLabel)
        self.runningTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.descriptionTextView)
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionTextView.backgroundColor = .clear
        self.addSubview(self.ratingsLabel)
        self.ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.voterCountLabel)
        self.voterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.poster)
        self.poster.translatesAutoresizingMaskIntoConstraints = false

        self.initializeContraints()
    }

    private func initializeContraints() {

        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 18),

            self.runningTimeLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4),
            self.runningTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.runningTimeLabel.heightAnchor.constraint(equalToConstant: 18),
            self.ratingsLabel.topAnchor.constraint(equalTo: self.runningTimeLabel.topAnchor),
            self.ratingsLabel.leadingAnchor.constraint(equalTo: self.runningTimeLabel.trailingAnchor, constant: 16),
            self.voterCountLabel.topAnchor.constraint(equalTo: self.runningTimeLabel.topAnchor),
            self.voterCountLabel.leadingAnchor.constraint(equalTo: self.ratingsLabel.trailingAnchor, constant: 2),

            self.poster.topAnchor.constraint(equalTo: self.runningTimeLabel.bottomAnchor, constant: 4),
            self.poster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.poster.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.poster.widthAnchor.constraint(equalTo: self.poster.heightAnchor, multiplier: 0.6666),

            self.descriptionTextView.topAnchor.constraint(equalTo: self.poster.topAnchor),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.poster.trailingAnchor, constant: 6),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            self.descriptionTextView.heightAnchor.constraint(lessThanOrEqualTo: self.poster.heightAnchor)
        ])
    }

    func loadInfo() {
        self.backgroundColor = .clear

        if movieInfo.posterPath != nil {
            self.poster.downloadImage(urlString: imageURLBasePath + movieInfo.posterPath!)
            self.poster?.clipsToBounds = true
        }

        let releaseYear = movieInfo.releaseDate != nil ? movieInfo.releaseDate!.prefix(4) : "Unknown"
        self.nameLabel.text = self.movieInfo.title + " (" + releaseYear + ")"
        self.nameLabel.font = UIFont(name: boldFontName, size: 16.0)
        self.nameLabel.textColor = .white
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.runningTimeLabel.text = runningTime()
        self.runningTimeLabel.font = UIFont(name: baseFontName, size: 14.0)
        self.runningTimeLabel.textColor = .white
        self.ratingsLabel.text = ratingsInfo()
        self.ratingsLabel.font = UIFont(name: baseFontName, size: 14.0)
        self.ratingsLabel.textColor = .white
        self.voterCountLabel.text = self.movieInfo.voteCount != nil ? "(\(self.movieInfo.voteCount!))" : ""
        self.voterCountLabel.font = UIFont(name: baseFontName, size: 14.0)
        self.voterCountLabel.textColor = .white
        self.descriptionTextView.textAlignment = .left
        self.descriptionTextView.font = UIFont(name: baseFontName, size: 14.0)
        self.descriptionTextView.text = self.movieInfo.overview
        self.descriptionTextView.backgroundColor = .clear
        self.descriptionTextView.textColor = .white
        self.descriptionTextView.clipsToBounds = true
        self.descriptionTextView.isEditable = false
    }

    private func runningTime() -> String {
        if self.movieInfo.runtime != nil {
            let hours = self.movieInfo.runtime! / 60
            let minutes = self.movieInfo.runtime! - (hours * 60)

            return "\(hours)h \(minutes)min"
        }

        return "Unkown"
    }

    private func ratingsInfo() -> String {
        if self.movieInfo.voteAverage != nil {
            return "\(self.movieInfo.voteAverage!) / 10"
        }

        return ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

