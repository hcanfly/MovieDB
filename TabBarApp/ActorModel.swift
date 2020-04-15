//
//  ActorModel.swift
//  TabBarApp
//
//  Created by Gary on 4/15/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation


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

struct ListActor: Decodable {
    let id: Int
    let name: String
}

struct ListActors: Decodable {
    let actors: [ListActor]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

extension ListActors {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        actors = try? values.decode([ListActor].self, forKey: .results)
    }
}
