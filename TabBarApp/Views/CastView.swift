//
//  CastView.swift
//  TabBarApp
//
//  Created by Gary on 3/2/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit

final class CastView: UIView {
    var coordinator: ActorCoordinator?
    var cast: Cast!
    private var label = UILabel()
    private var tableView = UITableView()


    convenience init(frame: CGRect, coordinator: ActorCoordinator, cast: Cast) {
        self.init(frame: frame)

        self.coordinator = coordinator
        self.cast = cast
        self.backgroundColor = .systemPink

        self.label.text = "Cast:"
        self.label.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.label.textColor = .white
        self.addSubview(self.label)

        setupTableView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.label.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        self.tableView.frame = CGRect(x: 0, y: 22, width: self.bounds.width, height: self.bounds.height - 20)
    }

    private func setupTableView() {
        self.tableView.backgroundColor = .systemPink
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = .clear
        self.addSubview(self.tableView)

        self.tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.reuseIdentifier)
    }

}


extension CastView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cast.cast!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else {
            fatalError("bad cell type in table view")
        }

        cell.textLabel?.text = self.cast!.cast![indexPath.row].name
        cell.detailTextLabel?.text = self.cast.cast![indexPath.row].character
        cell.selectionStyle = .none     // either this, or try setting to not selected after being selected and before calling coordinator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let castInfo = self.cast!.cast![indexPath.row]
        self.coordinator?.actorSelected(id: castInfo.id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 16   // 20
    }

}
