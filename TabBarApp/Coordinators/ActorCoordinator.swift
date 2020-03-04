//
//  ActorCoordinator.swift
//  TabBarApp
//
//  Created by Gary on 3/3/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit



final class ActorCoordinator: Coordinator {
    var navigationController: UINavigationController


    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func actorSelected(id: Int) {
        let actorVC = ActorViewController.instantiate()
        actorVC.coordinator = self
        actorVC.actorId = id

        self.navigationController.pushViewController(actorVC, animated: false)
    }
}
