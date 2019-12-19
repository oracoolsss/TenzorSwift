//
//  MostViewedService.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
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
  
  //period can be only 1, 7 or 30
  func getMostPopular(period: Int, completion: @escaping QueryResult) {
    dataTask?.cancel()
    
    guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/\(String(period)).json?api-key=84jUCMH3SDNn4YO8nOJOrmcd1Wm17u7K") else {
      return
    }
    
    dataTask = defaultSession.dataTask(with: url) { data, response, error in
      defer { self.dataTask = nil }
      if let error = error {
        self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
      } else if let data = data,
        let response = response as? HTTPURLResponse, response.statusCode == 200 {
        self.articles.removeAll()
        do {
          print("updating articles")
          var str = String(decoding: data, as: UTF8.self);
          str = str.replacingOccurrences(of: "\\/", with: "/")
          //TODO make JSON correcter
          for substr in ["per", "geo", "des", "org"] {
            str = str.replacingOccurrences(of: "\"\(substr)_facet\":\"\"", with: "\"\(substr)_facet\":[]")
          }
          str = str.replacingOccurrences(of: "caption\":null", with: "caption\":\"\"")
          str = str.replacingOccurrences(of: "copyright\":null", with: "copyright\":\"\"")
          
          var responseFromJSON = vaResponseBody(status: "", copyright: "", numResults: 0, results: [])
          do {
            responseFromJSON = try self.decoder.decode(vaResponseBody.self, from: str.data(using: .utf8)!)
          } catch DecodingError.dataCorrupted(let context) {
            print(DecodingError.dataCorrupted(context))
          }
          catch DecodingError.keyNotFound(let key, let context) {
            print(DecodingError.keyNotFound(key, context))
          }
          catch DecodingError.typeMismatch(let type, let context) {
            print(DecodingError.typeMismatch(type, context))
          }
          catch DecodingError.valueNotFound(let type, let context) {
            print(DecodingError.valueNotFound(type, context))
          }

          self.articles = responseFromJSON.results
          print("updatied articles \(period)")
          if period == 30 {
            print(self.articles[0].abstract)
          }
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
