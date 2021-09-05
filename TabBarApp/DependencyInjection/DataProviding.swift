//
//  DataProviding.swift
//  DataProviding
//
//  Created by Gary Hanson on 9/4/21.
//  Copyright © 2021 Gary Hanson. All rights reserved.
//

import Foundation


public struct DataProviderKey: InjectionKey {
    public static var currentValue: DataProviding = DataFetcher.shared
}


extension InjectedValues {
    var dataProvider: DataProviding {
        get { Self[DataProviderKey.self] }
        set { Self[DataProviderKey.self] = newValue }
    }
}


public protocol DataProviding {
    
    func getMoviesNowPlaying<T: Decodable>(myType: T.Type) async -> T?

    func getUpcomingMovies<T: Decodable>(myType: T.Type) async -> T?

    func getMatchingMovies<T: Decodable>(title: String, myType: T.Type) async -> T?

    func getMatchingActors<T: Decodable>(name: String, myType: T.Type) async -> T?

    func getMovieInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T?

    func getCastInfo<T: Decodable>(movieId: Int, myType: T.Type) async -> T?

    func getActorInfo<T: Decodable>(actorId: Int, myType: T.Type) async -> T?
}
