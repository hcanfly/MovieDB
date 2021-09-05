//
//  UpcomingViewController.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class UpcomingViewController: UIViewController, Storyboarded {
    weak var coordinator: UpcomingMovieCoordinator?
    private var upcomingMovies: ListMovies?
    private var tableView = UITableView()


    override func loadView() {
        super.loadView()

        self.title = "Upcoming"
        self.tableView.showsVerticalScrollIndicator = false

        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    private func loadData() {
        Task {
            let upcoming = await DataDownloader.getUpcomingMovies(myType: ListMovies.self)
            if let upcoming = upcoming {
                self.upcomingMovies = upcoming
                self.tableView.reloadData()
            }
        }
    }
    

    private func setupTableView() {
        self.tableView.frame = self.view.frame.insetBy(dx: 20, dy: 80)
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = .clear
        self.view.addSubview(self.tableView)

        self.tableView.register(ListMovieTableViewCell.self, forCellReuseIdentifier: ListMovieTableViewCell.reuseIdentifier)
    }

}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.upcomingMovies == nil ? 0 : self.upcomingMovies!.movies!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTableViewCell.reuseIdentifier, for: indexPath) as? ListMovieTableViewCell else {
            fatalError("bad cell type in table view")
        }

        let movieInfo = self.upcomingMovies!.movies![indexPath.row]
        cell.nameLabel.text = movieInfo.title
        cell.descriptionLabel.text = movieInfo.overview
        if movieInfo.posterPath != nil {
            cell.addPoster(posterPath: movieInfo.posterPath!)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfo = self.upcomingMovies!.movies![indexPath.row]
        self.coordinator?.movieSelected(id: movieInfo.id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
