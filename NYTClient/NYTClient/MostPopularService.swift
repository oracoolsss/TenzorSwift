//
//  MostPopularService.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import Foundation

class MostPopularService {
  typealias QueryResult = ([ViewedArticle]?, String?) -> ()
  var articles: [ViewedArticle] = []
  var errorMessage = ""
  
  lazy var defaultSession: URLSession = {
    let config = URLSessionConfiguration.default
    config.waitsForConnectivity = true
    return URLSession(configuration: config)
  }()
  var dataTask: URLSessionDataTask?
  let decoder = JSONDecoder()
  
  func getMostPopular(completion: @escaping QueryResult) {
    dataTask?.cancel()
    
    guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=84jUCMH3SDNn4YO8nOJOrmcd1Wm17u7K") else {
      return
    }
    
    dataTask = defaultSession.dataTask(with: url) { data, response, error in
      //print(url)
      //print(getKey())
      defer { self.dataTask = nil }
      if let error = error {
        self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
      } else if let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 {
        print("da")
        
        self.articles.removeAll()
        do {
          //data.
          print("updating articles")
          var str = String(decoding: data, as: UTF8.self);
          str = str.replacingOccurrences(of: "\\/", with: "/")
          for substr in ["per", "geo", "des", "org"] {
            str = str.replacingOccurrences(of: "\"\(substr)_facet\":\"\"", with: "\"\(substr)_facet\":[]")
          }
          let responseFromJSON = try self.decoder.decode(vaResponseBody.self, from: str.data(using: .utf8)!)
          self.articles = responseFromJSON.results
        } catch let decodeError as NSError {
          self.errorMessage += "Decoder error: \(decodeError.localizedDescription)"
          return
        }
        
        OperationQueue.main.addOperation {
          completion(self.articles, self.errorMessage)
        }
      }
    }
    dataTask?.resume()
  }
  
}
