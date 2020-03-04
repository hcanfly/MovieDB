//
//  UpcomingMovieCoordinator.swift
//  TabBarApp
//
//  Created by Gary on 3/1/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class UpcomingMovieCoordinator: Coordinator {
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController

        let viewController = UpcomingViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(named: "first"), tag: 2)
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
