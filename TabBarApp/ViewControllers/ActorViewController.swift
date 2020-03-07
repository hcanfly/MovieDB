//
//  ActorViewController.swift
//  TabBarApp
//
//  Created by Gary on 3/3/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit



final class ActorViewController: UIViewController, Storyboarded {
    weak var coordinator: Coordinator?
    var actorId = 0
    private var actor: Actor!
    private var actorView: ActorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attrs
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "RedCurtain")!)

        let actorURL = "https://api.themoviedb.org/3/person/\(self.actorId)?api_key=\(tmdbKey)"
        fetchNetworkData(urlString: actorURL, myType: Actor.self) { [weak self] actor in
             if let self = self {
                self.actor = actor
                self.title = actor.name
                let edgeInsets = self.view.safeAreaInsets
                self.actorView = ActorView(frame: CGRect(x: 10, y: edgeInsets.top + 10, width: self.view.bounds.width - 20, height: self.view.bounds.height * 0.5), actorInfo: actor)
                self.view.addSubview(self.actorView)
                }
         }

    }
}
