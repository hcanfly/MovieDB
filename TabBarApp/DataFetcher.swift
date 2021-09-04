//
//  DataFetcher.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation

let tmdbKey = "e1ca1713c055f737455c5a27de78f41d"   // "<your tmdb api key goes here>"
let imageURLBasePath = "https://image.tmdb.org/t/p/w500"        // w500 specifies image width
let nowPlayingURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(tmdbKey)"
let upcomingURLString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(tmdbKey)"
let searchBaseURLString = "https://api.themoviedb.org/3/search/movie?api_key=\(tmdbKey)&query="
let searchActorsBaseURLString = "https://api.themoviedb.org/3/search/person?api_key=\(tmdbKey)&query="


enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case invalidJSONResponse
}

enum NetworkData {
    // download data and decode from JSON

    static func fetch<T: Decodable>(url: URL?, myType: T.Type) async throws -> T {
        guard let url = url else {
            print("Invalid URL. Did you enter your newsapi api key in Network.swift?")
            throw NetworkError.invalidURL
          }
        
        let session = URLSession.shared

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidServerResponse
        }
        
        //print(String(bytes: data, encoding: String.Encoding.utf8))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let theData = try decoder.decode(T.self, from: data)

        return theData
    }

    static func getInfo<T: Decodable>(for url: URL, myType: T.Type) async -> T? {
       do {
            let info = try await fetch(url: url, myType: T.self)
            
            return info
        } catch {
            print(error)    // handle errors here. return nil so UI doesn't have to
            return nil
        }
    }
    
    static func getMoviesNowPlaying<T: Decodable>(myType: T.Type) async -> T? {
        let info = await getInfo(for: .nowPlaying!, myType: T.self)

        return info
    }

    static func getUpcomingMovies<T: Decodable>(myType: T.Type) async -> T? {
        let info = await getInfo(for: .upcoming!, myType: T.self)

        return info
    }

    static func getMatchingMovies<T: Decodable>(title: String, myType: T.Type) async -> T? {
        let info = await getInfo(for: .matchingMovies(withNameLike: title)!, myType: T.self)

        return info
    }

    static func getMatchingActors<T: Decodable>(name: String, myType: T.Type) async -> T? {
        let info = await getInfo(for: .matchingActors(withNameLike: name)!, myType: T.self)

        return info
    }

    static func getMovieInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T? {
        let info = await getInfo(for: .movieInfo(withId: movieId)!, myType: T.self)

        return info
    }

    static func getCastInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T? {
        let info = await getInfo(for: .castInfo(withId: movieId)!, myType: T.self)

        return info
    }

    static func getActorInfo<T: Decodable>(actorId: Int, myType: T.Type) async -> T? {
        let info = await getInfo(for: .actorInfo(withId: actorId)!, myType: T.self)

        return info
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

    static func matchingActors(withNameLike name: String) -> URL? {
        URL(string: searchActorsBaseURLString + "\(name)")
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
