//
//  URL.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 06/10/22.
//

import Foundation

struct Url {
    
    static let API_KEY = "a8c1bddba274b382a6d02d1c990f3c8e"
    
    static var urlBase: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        return components
    }
    
    static var urlTrendingMovies: URL {
        var urlComponents = urlBase
        urlComponents.path = "/3/trending/movie/day"
        urlComponents.query = "api_key=\(API_KEY)"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    static var urlTrendingTvs: URL {
        var urlComponents = urlBase
        urlComponents.path = "/3/trending/tv/day"
        urlComponents.query = "api_key=\(API_KEY)"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    static var urlUpcommingMovies: URL {
        var urlComponents = urlBase
        urlComponents.path = "/3/movie/upcoming"
        urlComponents.query = "api_key=\(API_KEY)&language=en-US&page=1"
        print(urlComponents.url!)
        return urlComponents.url!
    }

    static var urlPopularMovies: URL {
        var urlComponents = urlBase
        urlComponents.path = "/3/movie/popular"
        urlComponents.query = "api_key=\(API_KEY)&language=en-US&page=1"
        print(urlComponents.url!)
        return urlComponents.url!
    }
    
    static var urlTopRatedMovies: URL {
        var urlComponents = urlBase
        urlComponents.path = "/3/movie/top_rated"
        urlComponents.query = "api_key=\(API_KEY)&language=en-US&page=1"
        print(urlComponents.url!)
        return urlComponents.url!
    }
}
