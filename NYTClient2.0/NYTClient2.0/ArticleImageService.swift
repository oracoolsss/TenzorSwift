//
//  ArticleImageService.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import Foundation

class ArticleImageService {
  private let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
  
  func loadImageFromCloud(url: URL, completion: @escaping (Data?, String?)->()) {
    let task = urlSession.dataTask(with: url) { (data, response, error) in
      guard let data = data, let response = response as? HTTPURLResponse else {
        completion(nil, nil)
        return
      }
      completion(data, HTTPURLResponse.localizedString(forStatusCode: response.statusCode))
    }
    
    task.resume()
  }
}
