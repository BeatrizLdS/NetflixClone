//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 06/10/22.
//

import Foundation

enum APIError: Error{
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = Url.urlTrendingMovies
        let request = URLRequest(url: url)
        executeMoviesResquest(urlRequest: request, completion: completion)
    }
    
    func getUpcommingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        let url = Url.urlUpcommingMovies
        let request = URLRequest(url: url)
        executeMoviesResquest(urlRequest: request, completion: completion)
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        let url = Url.urlPopularMovies
        let request = URLRequest(url: url)
        executeMoviesResquest(urlRequest: request, completion: completion)
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        let url = Url.urlTopRatedMovies
        let request = URLRequest(url: url)
        executeMoviesResquest(urlRequest: request, completion: completion)
    }
    
    func executeMoviesResquest(urlRequest: URLRequest, completion: @escaping (Result<[Movie], Error>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
    
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        dataTask.resume()
    }

}
