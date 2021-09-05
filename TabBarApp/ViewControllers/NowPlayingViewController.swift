//
//  NowPlayingViewController.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.


import UIKit


final class NowPlayingViewController: UIViewController, Storyboarded {
    weak var coordinator: NowPlayingMovieCoordinator?
    private var nowShowingMovies: ListMovies?
    private var tableView = UITableView()


    override func loadView() {
        super.loadView()

        self.title = "Now Playing"
        self.tableView.showsVerticalScrollIndicator = false

        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let nowPlaying = await DataDownloader.getMoviesNowPlaying(myType: ListMovies.self)
            if let nowPlaying = nowPlaying {
                self.nowShowingMovies = nowPlaying
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

extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nowShowingMovies == nil ? 0 : self.nowShowingMovies!.movies!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTableViewCell.reuseIdentifier, for: indexPath) as? ListMovieTableViewCell else {
            fatalError("bad cell type in table view")
        }

        let movieInfo = self.nowShowingMovies!.movies![indexPath.row]
        cell.nameLabel.text = movieInfo.title
        cell.descriptionLabel.text = movieInfo.overview
        if movieInfo.posterPath != nil {
            cell.addPoster(posterPath: movieInfo.posterPath!)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfo = self.nowShowingMovies!.movies![indexPath.row]
        self.coordinator?.movieSelected(id: movieInfo.id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
