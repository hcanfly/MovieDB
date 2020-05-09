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
    @IBOutlet weak var actorView: ActorView!

    override func loadView() {
        super.loadView()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "RedCurtains2")!)

        self.view.addSubview(self.actorView)

        self.actorView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkData.getActorInfo(actorId: self.actorId, myType: Actor.self) { [weak self] actor in
            if let self = self {
                self.title = actor.name
                self.actorView.setActorInfo(actorInfo: actor)
                self.view.addSubview(self.actorView)
                self.setupConstraints()
                }
            }
    }

    private func setupConstraints() {
        let edgeInsets = self.view.safeAreaInsets

        NSLayoutConstraint.activate([
        self.actorView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: edgeInsets.left),
        self.actorView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
        self.actorView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: edgeInsets.bottom),
        self.actorView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: edgeInsets.right)
        ])
    }
}
