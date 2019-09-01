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
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchTopStories(page: Int, successHandler: @escaping (([Story]) -> Void)) {
        var urlRequest = URLRequest(url: url(for: .bbcNews, page: page))
        urlRequest.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            var serializedJSONResponse: Any
            do {
                serializedJSONResponse = try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
                return
            }
            
            guard let json = serializedJSONResponse as? [String:Any] else { return }
            let jsonParser = JSONParser()
            let stories = jsonParser.stories(from: json)
            successHandler(stories)
        }
        task.resume()
    }
    
    private func url(for source: Source, page: Int) -> URL {
        var url = URLComponents(string: basePath)!
        url.queryItems = [
            URLQueryItem(name: "source", value: source.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        return url.url!
    }
}

enum Source: String {
    case bbcNews = "bbc-news"
}
