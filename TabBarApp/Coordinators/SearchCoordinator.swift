//
//  SearchCoordinator.swift
//  TabBarApp
//
//  Created by Gary on 3/2/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController


    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController

        //let viewController = SearchSelectorViewController.instantiate()
        let viewController = SearchViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        viewController.coordinator = self
        viewController.searchType = .movie

        navigationController.viewControllers = [viewController]
    }

    func movieSelected(id: Int) {
        let movieVC = MovieViewController.instantiate()
        movieVC.coordinator = self
        movieVC.movieId = id

        self.navigationController.pushViewController(movieVC, animated: false)
    }

    // search for tv and actor not implemented
    func search(for type: SearchType) {
        let viewController = SearchViewController.instantiate()
        viewController.coordinator = self
        viewController.searchType = type

        navigationController.pushViewController(viewController, animated: true)
    }
}
