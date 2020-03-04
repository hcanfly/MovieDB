//
//  NowPlayingMovieCoordinator.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class NowPlayingMovieCoordinator: Coordinator {
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController

        let viewController = NowPlayingViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(named: "second"), tag: 0)
        viewController.coordinator = self

        navigationController.viewControllers = [viewController]
    }

    func movieSelected(id: Int) {
        let movieVC = MovieViewController.instantiate()
        movieVC.coordinator = self
        movieVC.movieId = id

        self.navigationController.pushViewController(movieVC, animated: false)
    }
}
