//
//  MovieModel.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 07/10/22.
//

import Foundation

struct TrendingMoviesResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String?
    let media:  String?
    let overview: String?
    let poster: String?
    let releaseDate: String?
    let voteCount: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey{
        case id, title, overview
        case media = "media_type"
        case poster = "poster_path"
        case releaseDate = "release_data"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}
