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
