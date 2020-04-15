//
//  SearchSelectorViewController.swift
//  TabBarApp
//
//  Created by Gary on 3/7/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit
/*

enum SearchType {
    case movie
    case tv
    case actor
}


class SearchSelectorViewController: UIViewController, Storyboarded {
    weak var coordinator: SearchCoordinator?

    var moviePosterButton: UIButton!
    var tvshowPosterButton: UIButton!
    var actorPosterButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search"
        let buttonHeight = self.view.frame.height * 0.3
        let buttonWidth = buttonHeight * 0.75
        self.moviePosterButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        self.moviePosterButton.setImage(UIImage(named: "GoneWithTheWind2"), for: .normal)
        self.moviePosterButton.addTarget(self, action: #selector(searchMoviesSelected), for: .touchUpInside)
        self.view.addSubview(self.moviePosterButton)

        self.tvshowPosterButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        self.tvshowPosterButton.setImage(UIImage(named: "Friends2"), for: .normal)
        self.tvshowPosterButton.addTarget(self, action: #selector(searchTVSelected), for: .touchUpInside)
        self.view.addSubview(self.tvshowPosterButton)

        self.actorPosterButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        self.actorPosterButton.setImage(UIImage(named: "MattDamon2"), for: .normal)
        self.actorPosterButton.addTarget(self, action: #selector(searchActorsSelected), for: .touchUpInside)

        self.view.addSubview(self.actorPosterButton)

        self.view.backgroundColor = .systemPink
    }

    // not implemented
    @objc func searchMoviesSelected() {
        coordinator?.search(for: .movie)
    }

    @objc func searchTVSelected() {
        coordinator?.search(for: .tv)
    }

    @objc func searchActorsSelected() {
        coordinator?.search(for: .actor)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let buttonHeight = self.view.frame.height * 0.26
        let buttonWidth = buttonHeight * 0.75
        let insets = self.view.safeAreaInsets
        self.moviePosterButton.frame = CGRect(x: 130, y: insets.top + 10, width: buttonWidth, height: buttonHeight)
        self.tvshowPosterButton.frame = CGRect(x: 130, y: insets.top  + 10 + buttonHeight + 10, width: buttonWidth, height: buttonHeight)
        self.actorPosterButton.frame = CGRect(x: 130, y: insets.top + 10  + buttonHeight + buttonHeight + 20, width: buttonWidth, height: buttonHeight)
    }


}
*/

