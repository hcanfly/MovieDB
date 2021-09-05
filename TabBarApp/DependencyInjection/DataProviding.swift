//
//  DataProviding.swift
//  DataProviding
//
//  Created by Gary Hanson on 9/4/21.
//  Copyright © 2021 Gary Hanson. All rights reserved.
//

/*
    DataProviding is a Singleton method of dependency injection. It is probably
    most appropriate when you have single source for a service, like networking,
    that you want to be able to test.
    It is initialized to be the network data source. Changing this will change
    downloading globally. It can be set in each viewcontroller for example. But the most
    common use would be to change this in the AppDelegate to use the mock data source for
    testing. If the injection is global than setting them in the AppDelegate makes a very
    clean way to do testing. There is commented off code there to use the mock service.
 */
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
