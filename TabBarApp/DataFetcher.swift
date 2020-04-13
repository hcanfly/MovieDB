//
//  DataFetcher.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation

let tmdbKey = "e1ca1713c055f737455c5a27de78f41d"   // "<your TMDb api key goes here>"
let imageURLBasePath = "https://image.tmdb.org/t/p/w500"        // w500 specifies image width
let nowPlayingURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(tmdbKey)"
let upcomingURLString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(tmdbKey)"
let searchBaseURLString = "https://api.themoviedb.org/3/search/movie?api_key=\(tmdbKey)&query="
let searchActorsBaseURLString = "https://api.themoviedb.org/3/search/person?api_key=\(tmdbKey)&query="


// download data and decode from JSON
func fetchNetworkData<T: Decodable>(url: URL?, myType: T.Type, completion: @escaping (T) -> Void) {
      guard let url = url else {
        print("did you enter your TMBD api key in DataFetcher.swift?")
        return
      }

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data {
            let jsonDecoder = JSONDecoder()
            do {
                let theData = try jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(theData)
                }
            } catch {
                print("Error parsing JSON")
            }
        } else {
            print("Download error: " + error!.localizedDescription)
        }
    }

    task.resume()
}


func getMoviesNowPlaying<T: Decodable>(myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(url: .nowPlaying, myType: T.self) { nowPlaying in
        completion(nowPlaying)
    }
}

func getUpcomingMovies<T: Decodable>(myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(url: .upcoming, myType: T.self) { nowPlaying in
        completion(nowPlaying)
    }
}

func getMatchingMovies<T: Decodable>(title: String, myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(url: .matchingMovies(withNameLike: title), myType: T.self) { foundTitles in
         completion(foundTitles)
     }
}

func getMovieInfo<T: Decodable>(movieId: Int, myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(url: .movieInfo(withId: movieId), myType: T.self) { movie in
         completion(movie)
    }
}

func getCastInfo<T: Decodable>(movieId: Int, myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(url: .castInfo(withId: movieId), myType: T.self) { cast in
        completion(cast)
    }
}

func getActorInfo<T: Decodable>(actorId: Int, myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(url: .actorInfo(withId: actorId), myType: T.self) { cast in
        completion(cast)
    }
}


extension URL {
    static var nowPlaying: URL? {
        URL(string: nowPlayingURLString)
    }

    static var upcoming: URL? {
        URL(string: upcomingURLString)
    }

    static func matchingMovies(withNameLike title: String) -> URL? {
        URL(string: searchBaseURLString + "\(title)")
    }

    static func movieInfo(withId id: Int) -> URL? {
        URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(tmdbKey)")
    }

    static func castInfo(withId id: Int) -> URL? {
        URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(tmdbKey)")
    }

    static func actorInfo(withId id: Int) -> URL? {
        URL(string: "https://api.themoviedb.org/3/person/\(id)?api_key=\(tmdbKey)")
    }
}
