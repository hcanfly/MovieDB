//
//  DataFetcher.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation


//let tmdbKey = //"<your tmdb api key goes here>"

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

class DataFetcher: DataProviding {
    public static let shared = DataFetcher()

    func fetch<T: Decodable>(url: URL?, myType: T.Type) async throws -> T {
        guard let url = url, tmdbKey != "<your tmdb api key goes here>" else {
            print("Invalid URL. Did you enter your newsapi api key in DataFetcher.swift?")
            throw NetworkError.invalidURL
          }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidServerResponse
        }
        
        //print(String(bytes: data, encoding: String.Encoding.utf8))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let theData = try decoder.decode(myType, from: data)

            return theData
        } catch {
            throw NetworkError.invalidJSONResponse
        }
    }

    func getInfo<T: Decodable>(for url: URL?, myType: T.Type) async -> T? {
       do {
            let info = try await fetch(url: url, myType: myType)
            
            return info
        } catch {
            print(error)    // handle errors here. return nil so UI doesn't have to deal with errors.
            return nil
        }
    }
    
    func getMoviesNowPlaying<T: Decodable>(myType: T.Type) async -> T? {
        let info = await getInfo(for: .nowPlaying, myType: myType)

        return info
    }

    func getUpcomingMovies<T: Decodable>(myType: T.Type) async -> T? {
        let info = await getInfo(for: .upcoming, myType: myType)

        return info
    }

    func getMatchingMovies<T: Decodable>(title: String, myType: T.Type) async -> T? {
        let info = await getInfo(for: .matchingMovies(withNameLike: title), myType: myType)

        return info
    }

    func getMatchingActors<T: Decodable>(name: String, myType: T.Type) async -> T? {
        let info = await getInfo(for: .matchingActors(withNameLike: name), myType: myType)

        return info
    }

    func getMovieInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T? {
        let info = await getInfo(for: .movieInfo(withId: movieId), myType: myType)

        return info
    }

    func getCastInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T? {
        let info = await getInfo(for: .castInfo(withId: movieId), myType: myType)

        return info
    }

    func getActorInfo<T: Decodable>(actorId: Int, myType: T.Type) async -> T? {
        let info = await getInfo(for: .actorInfo(withId: actorId), myType: myType)

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
