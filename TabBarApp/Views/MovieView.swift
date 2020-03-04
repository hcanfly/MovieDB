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
    private let descriptionLabel: UILabel
    private let voterCountLabel: UILabel
    private var poster: AsyncImageView?
    private var movieInfo = Movie(id: 0, imdbId: "", title: "", overView: "", backdropPath: nil, posterPath: nil, releaseDate: "", runtime: 100, voteAverage: nil, voteCount: nil)

    override func layoutSubviews() {
        super.layoutSubviews()

        let desiredImageHeight = CGFloat(self.bounds.height * 0.7)
        if movieInfo.posterPath != nil {
            self.poster = AsyncImageView(frame: CGRect(x: 0, y: 50, width: desiredImageHeight * 0.666666, height: desiredImageHeight), urlString: imageURLBasePath + movieInfo.posterPath!)
            self.poster?.clipsToBounds = true
            self.addSubview(self.poster!)
        }

        self.nameLabel.frame = CGRect(x: 0, y: 0, width: 360, height: 20)
        self.descriptionLabel.frame = CGRect(x: desiredImageHeight * 0.666666 + 16, y: 50, width: self.bounds.width > 370 ? 150 : 120, height: self.bounds.height - 60)
        self.descriptionLabel.sizeToFit()
        self.runningTimeLabel.frame = CGRect(x: 0, y: 20, width: 100, height: 20)
        self.ratingsLabel.frame = CGRect(x: 80, y: 20, width: 60, height: 20)
        self.voterCountLabel.frame = CGRect(x: 128, y: 20, width: 60, height: 20)
    }

    convenience init(frame: CGRect, movieInfo: Movie) {
        self.init(frame: frame)

        self.backgroundColor = .clear

        self.movieInfo = movieInfo
        let releaseYear = movieInfo.releaseDate != nil ? movieInfo.releaseDate!.prefix(4) : "Unknown"
        self.nameLabel.text = self.movieInfo.title + " (" + releaseYear + ")"
        self.nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        self.nameLabel.textColor = .white
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.runningTimeLabel.text = runningTime()
        self.runningTimeLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        self.runningTimeLabel.textColor = .white
        self.ratingsLabel.text = ratingsInfo()
        self.ratingsLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        self.ratingsLabel.textColor = .white
        self.voterCountLabel.text = self.movieInfo.voteCount != nil ? "(\(self.movieInfo.voteCount!))" : ""
        self.voterCountLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        self.voterCountLabel.textColor = .white
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.lineBreakMode = .byTruncatingTail
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 14.0)
        self.descriptionLabel.text = self.movieInfo.overView
        self.descriptionLabel.textColor = .white
        self.addSubview(self.descriptionLabel)
    }

    override init(frame: CGRect) {
        self.nameLabel = UILabel(frame: CGRect.zero)
        self.descriptionLabel = UILabel(frame: CGRect.zero)
        self.runningTimeLabel = UILabel(frame: CGRect.zero)
        self.ratingsLabel = UILabel(frame: CGRect.zero)
        self.voterCountLabel = UILabel(frame: CGRect.zero)

        super.init(frame: frame)

        self.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        self.frame = frame
        self.addSubview(self.nameLabel)
        self.addSubview(self.runningTimeLabel)
        self.addSubview(self.runningTimeLabel)
        self.addSubview(self.ratingsLabel)
        self.addSubview(self.voterCountLabel)
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
