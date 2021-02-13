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
    private var label: UILabel!
    private var tableView: UITableView!
    var cast: Cast!  {
           didSet {
            self.tableView.reloadData()
           }
       }

    convenience init(frame: CGRect, coordinator: ActorCoordinator) {
        self.init(frame: frame)

        self.coordinator = coordinator
        self.backgroundColor = .systemPink
        self.translatesAutoresizingMaskIntoConstraints = false

        self.label = UILabel(frame: CGRect.zero)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.label)
        self.tableView = UITableView(frame: CGRect.zero)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)

        self.label.text = "Cast:"
        self.label.font = UIFont(name: baseFontName, size: 16.0)
        self.label.textColor = .white

        self.setupTableView()
        self.initializeContraints()
    }

    private func initializeContraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),

            self.tableView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 2),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.safeAreaInsets.bottom - 14),

            ])
    }

    private func setupTableView() {
        self.tableView.backgroundColor = .systemPink
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = .clear

        self.tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.reuseIdentifier)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CastView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cast == nil ? 0 : self.cast.cast!.count
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

