//
//  MockData.swift
//  MockData
//
//  Created by Gary Hanson on 9/4/21.
//  Copyright © 2021 Gary Hanson. All rights reserved.
//

import Foundation


public class MockData {
    public static let shared = MockData()
    
    public func getUpcomingMovies<T>(myType: T.Type) async -> T? where T : Decodable {
        var movieList = ListMovies()
        let movie = ListMovie(id: 0, title: "My Favorite Upcoming Mock Movie", posterPath: nil, backdropPath: nil, overview: "Some really good stuff happens", releaseDate: nil, popularity: nil)
        
        movieList.movies = [movie]
        return movieList as? T
    }
    
    public func getMatchingMovies<T>(title: String, myType: T.Type) async -> T? where T : Decodable {
        var movieList = ListMovies()
        let movie = ListMovie(id: 0, title: "My Favorite Matching Mock Movie", posterPath: nil, backdropPath: nil, overview: "Some really good stuff happens", releaseDate: nil, popularity: nil)
        
        movieList.movies = [movie]
        return movieList as? T
    }
    
    public func getMatchingActors<T>(name: String, myType: T.Type) async -> T? where T : Decodable {
        var actorList = ListActors()
        let actor = ListActor(id: 43423, name: "An Actor")
        
        actorList.actors = [actor]
        return actorList as? T
    }
    
    public func getMovieInfo<T>(movieId: Int, myType: T.Type) async -> T? where T : Decodable {
        let movie = ListMovie(id: 0, title: "Another Favorite Mock Movie", posterPath: nil, backdropPath: nil, overview: "Some really good stuff happens", releaseDate: nil, popularity: nil)

        return movie as? T
    }
    
    public func getCastInfo<T>(movieId: Int, myType: T.Type) async -> T? where T : Decodable {
        var cast = Cast()
        let castActor = CastActor(id: 0, character: "Character Name", name: "Name", profilePath: nil)
        
        cast.cast = [castActor]
        return cast as? T
    }
    
    public func getMoviesNowPlaying<T: Decodable>(myType: T.Type) async -> T? {
        var movieList = ListMovies()
        let movie = ListMovie(id: 0, title: "My Favorite Now Playing Mock Movie", posterPath: nil, backdropPath: nil, overview: "Some really good stuff happens", releaseDate: nil, popularity: nil)
        
        movieList.movies = [movie]
        return movieList as? T
    }

    public func getActorInfo<T: Decodable>(actorId: Int, myType: T.Type) async -> T? {
        let actorInfo = Actor(id: 0, name: "Mock Actor", birthday: "", deathday: nil, biography: "A very well-known actor", placeOfBirth: nil, profilePath: "https://www.indiewire.com/wp-content/uploads/2020/07/AP_18242018027259.jpg?resize=800,533")
        return actorInfo as? T
    }
}
