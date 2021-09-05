//
//  DataDownloader.swift
//  DataDownloader
//
//  Created by Gary Hanson on 9/4/21.
//  Copyright © 2021 Gary Hanson. All rights reserved.
//

import Foundation

class DataDownloader {
    @Injected(\.dataProvider) static var dataProvider: DataProviding
    
    static func getMoviesNowPlaying<T: Decodable>(myType: T.Type) async -> T? {
        return await dataProvider.getMoviesNowPlaying(myType: myType)
    }

    static func getUpcomingMovies<T: Decodable>(myType: T.Type) async -> T? {
        return await dataProvider.getUpcomingMovies(myType: myType)
    }

    static func getMatchingMovies<T: Decodable>(title: String, myType: T.Type) async -> T? {
        return await dataProvider.getMatchingMovies(title: title, myType: myType)
    }

    static func getMatchingActors<T: Decodable>(name: String, myType: T.Type) async -> T? {
        return await dataProvider.getMatchingActors(name: name, myType: myType)
    }

    static func getMovieInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T? {
        return await dataProvider.getMovieInfo(movieId: movieId, myType: myType)
    }

    static func getCastInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T? {
        return await dataProvider.getCastInfo(movieId: movieId, myType: myType)
    }

    static func getActorInfo<T: Decodable>(actorId: Int, myType: T.Type) async -> T? {
        return await dataProvider.getActorInfo(actorId: actorId, myType: myType)
    }
}
