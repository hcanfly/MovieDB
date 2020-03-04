//
//  TabViewController.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

/*
    Awesome data from TMDb. They require, and deserve, attribution but there are no About or Credits page for this sample app.
    Attribution: "This product uses the TMDb API but is not endorsed or certified by TMDb."
    Logo: https://www.themoviedb.org/about/logos-attribution
 */


import UIKit

final class TabBarController: UITabBarController {
    private let nowPlaying = NowPlayingMovieCoordinator()
    private let upcoming = UpcomingMovieCoordinator()
    private let search = SearchCoordinator()
    private var listMovies: ListMovies?

    
    override func viewDidLoad() {

        self.viewControllers = [self.nowPlaying.navigationController, self.upcoming.navigationController, self.search.navigationController]
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
    }
}
