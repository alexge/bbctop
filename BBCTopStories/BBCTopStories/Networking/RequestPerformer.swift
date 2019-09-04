//
//  RequestPerformer.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 01/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

protocol RequestPerformable: class {
    func fetchTopStories(page: Int, successHandler: @escaping (([Story]) -> Void))
}

final class RequestPerformer: RequestPerformable {
    
    private let basePath: String = "https://newsapi.org/v2/top-headlines"
    private let apiKey: String = "56ec127545f14bd6a0ce5c296b00cb2d"
    private var source: String
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared, sourceString: String) {
        self.urlSession = urlSession
        self.source = sourceString
    }
    
    func fetchTopStories(page: Int, successHandler: @escaping (([Story]) -> Void)) {
        var urlRequest = URLRequest(url: url(for: page))
        urlRequest.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard self != nil else { return }
            
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            guard let responseModel = JSONParser().responseModel(from: data) else {
                return
            }
            
            if let stories = responseModel.articles {
                successHandler(stories)
            } else {
                print(responseModel.code!)
                print(responseModel.message!)
            }
        }
        task.resume()
    }
    
    private func url(for page: Int) -> URL {
        var url = URLComponents(string: basePath)!
        url.queryItems = [
            URLQueryItem(name: "sources", value: source),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        return url.url!
    }
}
