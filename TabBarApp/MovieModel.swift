//
//  MovieModel.swift
//  TabBarApp
//
//  Created by Gary on 3/1/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit




struct Movie: Decodable {
    let id: Int
    let imdbId: String?
    let title: String
    let overView: String?
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imdbId = "imdb_id"
        case title = "title"
        case overView = "overview"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// shortened movie info from now playing, upcoming and popular lists
struct ListMovie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let overView: String?
    let releaseDate: String?
    let popularity: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overView = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case popularity = "popularity"
    }
}

extension ListMovie {

    init(from dict: [String: Any]) {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as! String
        self.posterPath = dict["poster_path"] as? String
        self.backdropPath = dict["backdrop_path"] as? String
        self.overView = dict["overview"] as! String?
        self.releaseDate = dict["release_date"] as! String?
        self.popularity = dict["popularity"] as! Double?
    }

}

struct ListMovies: Decodable {
    let movies: [ListMovie]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

extension ListMovies {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        movies = try? values.decode([ListMovie].self, forKey: .results)
    }
}



struct CastActor: Decodable {
    let id: Int
    let character: String
    let name: String
    let profile_path: String?
}

struct Cast: Decodable {
    let cast: [CastActor]?

    enum CodingKeys: String, CodingKey {
        case cast
    }
}


struct Actor: Decodable {
    let id: Int
    let name: String
    let birthday: String?
    let deathday: String?
    let biography: String?
    let place_of_birth: String?
    let profile_path: String?

    var born: String {
        return self.birthday != nil ? tbmdDateStringToFullDate(date: self.birthday!) : ""
    }

    var died: String {
        return self.deathday != nil ? tbmdDateStringToFullDate(date: self.deathday!) : ""
    }
}
