//
//  SearchActorsViewController.swift
//  TabBarApp
//
//  Created by Gary on 4/15/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//
//  It would have been straightforward to modify the SearchMoviesViewController to accept a
//  search type (movie or actor) and create separate datasources and delegates for the two
//  types. But, overall it would have added to complexity because of changes to coordinator, etc.
//  and this is sample code that I don't want to add complexity for something that isn't the
//  main point of the sample.
//

import UIKit


final class SearchActorsViewController: UIViewController, Storyboarded {
    weak var coordinator: SearchActorsCoordinator?
    private var tableView: UITableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var actors: ListActors?
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
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        //self.searchController.searchBar.setShowsCancelButton(false, animated: false)

        self.searchController.searchBar.placeholder = "Search Actors"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true

        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        NetworkData.getMatchingActors(name: title, myType: ListActors.self) { [weak self] foundActors in
            if let self = self {
                self.actors = foundActors
                self.tableView.reloadData()
            }
        }
    }
}



extension SearchActorsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actorInfo = self.actors!.actors![indexPath.row]
        self.coordinator?.actorSelected(id: actorInfo.id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}

extension SearchActorsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return self.actors == nil ? 0 : self.actors!.actors!.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

    cell.textLabel?.text = self.actors!.actors![indexPath.row].name
    cell.textLabel?.textColor = .white
    cell.backgroundColor = .clear

    return cell
  }
}

extension SearchActorsViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    self.debounceReload()
  }
}

extension SearchActorsViewController: UISearchControllerDelegate, UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count == 0
        {
            if self.actors != nil && self.actors!.actors!.count > 0 {
                self.actors = nil
                self.tableView.reloadData()
            }
        }
    }
}
