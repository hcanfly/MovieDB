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
    var movieId = 0

    private var actorCoordinator: ActorCoordinator?
    private var movieView: MovieView!
    private var castView: CastView!


//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }

    override func loadView() {
        super.loadView()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "RedCurtain")!)

        self.movieView = MovieView(frame: CGRect.zero)
        self.movieView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.movieView)

        self.actorCoordinator = ActorCoordinator(navigationController: self.navigationController!)
        self.castView = CastView(frame: CGRect.zero, coordinator: self.actorCoordinator!)
        self.castView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.castView)

        NSLayoutConstraint.activate([
            //self.movieView.widthAnchor.constraint(equalToConstant: 400),
            self.movieView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            self.movieView.heightAnchor.constraint(equalTo: self.movieView.widthAnchor, multiplier: 1.0),
            self.movieView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.movieView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -6),

            self.castView.topAnchor.constraint(equalTo: self.movieView.bottomAnchor, constant: 10),
            self.castView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            self.castView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 8),
            self.castView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),

        ])

        self.loadMovieInfo()

    }

    private func loadMovieInfo() {

        NetworkData.getMovieInfo(movieId: self.movieId, myType: Movie.self) { [weak self] movie in
            if let self = self {
                self.title = movie.title
                self.movieView.movieInfo = movie
                }
            }

        NetworkData.getCastInfo(movieId: self.movieId, myType: Cast.self) { [weak self] cast in
            if let self = self {
               self.castView.cast = cast
            }
         }
    }
}

