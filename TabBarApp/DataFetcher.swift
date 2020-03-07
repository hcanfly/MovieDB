//
//  DataFetcher.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation

let tmdbKey = "<your TMDb api key goes here>"    // "<your TMDb api key goes here>"
let imageURLBasePath = "https://image.tmdb.org/t/p/w500"        // w500 specifies image width
let nowPlayingURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(tmdbKey)&language=en-US&page=1"
let upcomingURLString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(tmdbKey)&language=en-US&page=1"
let searchBaseURLString = "https://api.themoviedb.org/3/search/movie?api_key=\(tmdbKey)&query="
let searchActorsBaseURLString = "https://api.themoviedb.org/3/search/person?api_key=\(tmdbKey)&page=1&include_adult=false&query="


// download data and decode from JSON
func fetchNetworkData<T: Decodable>(urlString: String, myType: T.Type, completion: @escaping (T) -> Void) {
      guard let url = URL(string: urlString) else {
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

    fetchNetworkData(urlString: nowPlayingURLString, myType: T.self) { nowPlaying in
        completion(nowPlaying)
    }
}

func getUpcomingMovies<T: Decodable>(myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(urlString: upcomingURLString, myType: T.self) { nowPlaying in
        completion(nowPlaying)
    }
}

func getMatchingMovies<T: Decodable>(title: String, myType: T.Type, completion: @escaping (T) -> Void) {

    fetchNetworkData(urlString: searchBaseURLString + "\(title)", myType: T.self) { foundTitles in
         completion(foundTitles)
     }
}

func getMovieInfo(movieId: Int, completion: @escaping (Movie) -> Void) {

    let movieURL = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(tmdbKey)"
    fetchNetworkData(urlString: movieURL, myType: Movie.self) { movie in
         completion(movie)
    }
}

func getCastInfo(movieId: Int, completion: @escaping (Cast) -> Void) {

    let castURL = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(tmdbKey)"
    fetchNetworkData(urlString: castURL, myType: Cast.self) { cast in
        completion(cast)
    }
}
