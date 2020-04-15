//
//  SearchActorsCoordinator.swift
//  TabBarApp
//
//  Created by Gary on 4/15/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class SearchActorsCoordinator: Coordinator {
    var navigationController: UINavigationController


    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController

        let viewController = SearchActorsViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(title: "Actors", image: UIImage(named: "Search2"), tag: 3)
        viewController.coordinator = self

        navigationController.viewControllers = [viewController]
    }

    func actorSelected(id: Int) {
        let actorVC = ActorViewController.instantiate()
        actorVC.coordinator = self
        actorVC.actorId = id

        self.navigationController.pushViewController(actorVC, animated: false)
    }

}
