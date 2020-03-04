//
//  MovieViewController.swift
//  TabBarApp
//
//  Created by Gary on 3/1/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit

final class MovieViewController: UIViewController, Storyboarded {
    weak var coordinator: Coordinator?
    var actorCoordinator: ActorCoordinator?
    var movieId = 0
    private var movie: Movie!
    private var cast: Cast!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var votingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.castTableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.reuseIdentifier)

        self.actorCoordinator = ActorCoordinator(navigationController: self.navigationController!)
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attrs
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "RedCurtain")!)

        self.loadMovieInfo()
    }

    private func loadMovieInfo() {
        getMovieInfo(movieId: self.movieId) { [weak self] movie in
             if let self = self {
                self.movie = movie
                self.title = movie.title
                self.imageView = AsyncImageView(frame: self.imageView.frame, urlString: imageURLBasePath + movie.posterPath!)
                self.view.addSubview(self.imageView)
                self.titleLabel.text = movie.title
                self.descriptionLabel.text = movie.overView
                self.descriptionLabel.sizeToFit()
                self.runningTimeLabel.text = self.runningTime()
                self.ratingsLabel.text = self.ratingsInfo()
                self.votingLabel.text = self.movie.voteCount != nil ? "(\(self.movie.voteCount!))" : ""
            }
         }
        getCastInfo(movieId: self.movieId) { [weak self] castInfo in
             if let self = self {
                self.cast = castInfo
                self.castTableView.reloadData()
            }
         }
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cast?.cast?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else {
            fatalError("bad cell type in table view")
        }

        cell.textLabel?.text = self.cast!.cast![indexPath.row].name
        cell.detailTextLabel?.text = self.cast.cast![indexPath.row].character
        cell.selectionStyle = .none     // either this, or try setting to not selected after being selected and before calling coordinator

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 16   // 20
    }
}


extension MovieViewController {

    private func runningTime() -> String {
        if self.movie.runtime != nil {
            let hours = self.movie.runtime! / 60
            let minutes = self.movie.runtime! - (hours * 60)

            return "\(hours)h \(minutes)min"
        }

        return "Unkown"
    }

    private func ratingsInfo() -> String {
        if self.movie.voteAverage != nil {
            return "\(self.movie.voteAverage!) / 10"
        }

        return ""
    }

}
