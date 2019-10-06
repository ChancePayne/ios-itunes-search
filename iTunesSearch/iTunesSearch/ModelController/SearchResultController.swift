//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Chance Payne on 10/5/19.
//  Copyright © 2019 Chance Payne. All rights reserved.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
// https://itunes.apple.com/search?country=us&term=transistor&entity=software
    
    var baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults: [SearchResultItem] = []
    
    func performSearch(search searchTerm: String, resultType: String, completion: @escaping (Error?) -> Void) {
        var components = URLComponents(url: baseURL.appendingPathComponent("search"), resolvingAgainstBaseURL: true)
        
        let queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: resultType)
        ]
        components?.queryItems = queryItems
        
        guard let requestUrl = components?.url else {
            completion(NSError(domain: "SearchResultController", code: 0, userInfo: [NSLocalizedDescriptionKey : "Malformed Url"]))
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching search results")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error, data empty")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.searchResults = try decoder.decode(SearchResults.self, from: data).results
                completion(nil)
            } catch {
                NSLog("Error parsing search results: \(error)")
                completion(error)
            }
        }
        dataTask.resume()
        
    }
}
