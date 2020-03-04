//
//  SearchViewController.swift
//  TabBarApp
//
//  Created by Gary on 3/2/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController, Storyboarded {
    weak var coordinator: SearchCoordinator?
    private var tableView: UITableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var movies: ListMovies?
    private let debouncer = Debouncer()
    private var debounceReload: (() -> Void)!

    
    override func viewDidLoad() {
    super.viewDidLoad()

    self.view.layer.contents = UIImage(named: "RedCurtains")?.cgImage
    self.view.layer.contentsGravity = .resizeAspectFill

    self.tableView.frame = self.view.frame.insetBy(dx: 20, dy: 180)
    self.tableView.backgroundColor = .clear
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.separatorColor = .clear
    self.view.addSubview(self.tableView)

    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")

    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Movies"
    navigationItem.searchController = searchController

    self.debounceReload = self.debouncer.debounce(delay: .seconds(1)) {
        if self.searchController.searchBar.text!.count > 1 {
            // just in case of an extra space. more than that - too bad
            let newstring = self.searchController.searchBar.text!.replacingOccurrences(of: "  ", with: " ")
            var searchString = newstring.replacingOccurrences(of: " ", with: "+")
            searchString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if searchString.count > 1 {
                self.findMatchingMovies(title: searchString)
            }
            }
        }
    }

    private func findMatchingMovies(title: String) {
        getMatchingMovies(title: title, myType: ListMovies.self) { [weak self] foundTitles in
            if let self = self {
                self.movies = foundTitles
                self.tableView.reloadData()
            }
        }
    }
}



extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfo = self.movies!.movies![indexPath.row]
        self.coordinator?.movieSelected(id: movieInfo.id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}

extension SearchViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return self.movies == nil ? 0 : self.movies!.movies!.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

    cell.textLabel?.text = self.movies!.movies![indexPath.row].title

    return cell
  }
}

extension SearchViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    self.debounceReload()
  }
}




class Debouncer {

    var currentWorkItem: DispatchWorkItem?

    func debounce(delay: DispatchTimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        return {  [weak self] in
            guard let self = self else { return }
            self.currentWorkItem?.cancel()
            self.currentWorkItem = DispatchWorkItem { action() }
            queue.asyncAfter(deadline: .now() + delay, execute: self.currentWorkItem!)
        }
    }
}
