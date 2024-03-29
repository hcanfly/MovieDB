//
//  SearchViewController.swift
//  TabBarApp
//
//  Created by Gary on 3/2/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit


final class SearchMoviesViewController: UIViewController, Storyboarded {
    weak var coordinator: SearchCoordinator?
    private var tableView: UITableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var movies: ListMovies?
    private let debouncer = Debouncer()
    private var debounceReload: (() -> Void)!


    override func loadView() {
        super.loadView()

        self.view.layer.contents = UIImage(named: "RedCurtains")?.cgImage
        self.view.layer.contentsGravity = .resizeAspectFill

        self.tableView.frame = self.view.frame.insetBy(dx: 20, dy: 180)
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = .clear
        self.view.addSubview(self.tableView)

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")

        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.autocapitalizationType = .none
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false

        self.searchController.searchBar.placeholder = "Search Movies"
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true

        self.setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.debounceReload = self.debouncer.debounce(delay: .seconds(1)) {
            if self.searchController.searchBar.text!.count > 1 {
                var cleanstring = self.searchController.searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                cleanstring = cleanstring.trimmingCharacters(in: .whitespacesAndNewlines)
                // just in case of an extra space inside string. more than that - too bad
                cleanstring = cleanstring.replacingOccurrences(of: "  ", with: " ")
                var searchString = cleanstring.replacingOccurrences(of: " ", with: "+")
                searchString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if searchString.count > 1 {
                    self.findMatchingMovies(title: searchString)
                }
            }
        }
    }

    private func setupConstraints() {
        let edgeInsets = self.view.safeAreaInsets

        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: edgeInsets.left),
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: edgeInsets.bottom),
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: edgeInsets.right)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.searchController.searchBar.becomeFirstResponder()
    }

    private func findMatchingMovies(title: String) {
        Task {
        let foundTitles = await DataDownloader.getMatchingMovies(title: title, myType: ListMovies.self)
            if let foundTitles = foundTitles {
                self.movies = foundTitles
                self.tableView.reloadData()
            }
        }
    }
}



extension SearchMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfo = self.movies!.movies![indexPath.row]
        self.coordinator?.movieSelected(id: movieInfo.id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}

extension SearchMoviesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return self.movies == nil ? 0 : self.movies!.movies!.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

    cell.textLabel?.text = self.movies!.movies![indexPath.row].title
    cell.textLabel?.textColor = .white
    cell.backgroundColor = .clear

    return cell
  }
}

extension SearchMoviesViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    self.debounceReload()
  }
}

extension SearchMoviesViewController: UISearchControllerDelegate, UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0
        {
            self.clearResults()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.clearResults()
    }

    func clearResults() {
        if self.movies != nil && self.movies!.movies!.count > 0 {
            self.movies = nil
            self.tableView.reloadData()
        }
    }
    
}
