//
//  APICaller-Tv.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 07/10/22.
//

import Foundation

extension APICaller {
    
    func getTrendingTvs(completion: @escaping (Result<[Tv], Error>) -> Void) {
        let url = Url.urlTrendingTvs
        let request = URLRequest(url: url)
        executeTvsResquest(urlRequest: request, completion: completion)
    }
    
    func executeTvsResquest(urlRequest: URLRequest, completion: @escaping (Result<[Tv], Error>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTvsResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
            
        })
        dataTask.resume()
    }
}
