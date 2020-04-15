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
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double?
    let voteCount: Int?
}


// shortened movie info from now playing, upcoming and popular lists
struct ListMovie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let popularity: Double?
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
    let profilePath: String?
}

struct Cast: Decodable {
    let cast: [CastActor]?
}

struct Actor: Decodable {
    let id: Int
    let name: String
    let birthday: String?
    let deathday: String?
    let biography: String?
    let placeOfBirth: String?
    let profilePath: String?

    var born: String {
        return self.birthday != nil ? tbmdDateStringToFullDate(date: self.birthday!) : ""
    }

    var died: String {
        return self.deathday != nil ? tbmdDateStringToFullDate(date: self.deathday!) : ""
    }
}
