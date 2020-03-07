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

    var movieView: MovieView!
    var castView: CastView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actorCoordinator = ActorCoordinator(navigationController: self.navigationController!)
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attrs
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "RedCurtain")!)

        self.loadMovieInfo()
    }

    private func loadMovieInfo() {
        let edgeInsets = self.view.safeAreaInsets
        let movieViewFrame = CGRect(x: 10, y: edgeInsets.top + 10, width: self.view.bounds.width - 20, height: self.view.bounds.height * 0.5)
        getMovieInfo(movieId: self.movieId) { [weak self] movie in
            if let self = self {
                self.title = movie.title
                self.movieView = MovieView(frame: movieViewFrame, movieInfo: movie)
                self.view.addSubview(self.movieView)
                }
            }

        getCastInfo(movieId: self.movieId) { [weak self] cast in
            if let self = self {
               let movieCast = cast

               let yOffset = movieViewFrame.size.height + movieViewFrame.origin.y - 40
                self.castView = CastView(frame: CGRect(x: 10, y: yOffset, width: movieViewFrame.width, height: self.view.frame.height - yOffset), coordinator: self.actorCoordinator!, cast: cast)
               self.castView.cast = movieCast
               self.view.addSubview(self.castView)
            }
         }
    }
}
