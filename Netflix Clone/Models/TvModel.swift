//
//  TvModel.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 07/10/22.
//

import Foundation

struct TrendingTvsResponse: Codable{
    let results: [Tv]
}

struct Tv: Codable{
    let id: Int
    let name: String?
    let poster: String?
    let media: String?
    let date: String?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey{
        case id, name
        case poster = "poster_path"
        case media = "media_type"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case date = "first_air_date"
    }
}
