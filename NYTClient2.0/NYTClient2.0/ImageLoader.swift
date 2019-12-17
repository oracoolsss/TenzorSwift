//
//  ImageLoader.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class ImageLoader {
  private let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
  private let cloudImageService = CloudImageService()
  func loadImage(mediaArray: [Media]) -> UIImage{
    let urlString = mediaArray[0].mediaMetadata.last!.url
    let url = URL(string: urlString)
    var loadedImage = UIImage()
    cloudImageService.loadImageFromCloud(url: url!) { (data, status) in
      guard let data = data, let status = status else {
        return
      }
      if let image = UIImage(data: data) {
        loadedImage = image
        return
      }
      else {
        loadedImage =  UIImage(named: "cheboxary.jpg")!
      }
    }
    return loadedImage
  }
  
}

class CloudImageService {
  private let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
  
  func loadImageFromCloud(url: URL, completion: @escaping (Data?, String?)->()) {
    print("1")
    let task = urlSession.dataTask(with: url) { (data, response, error) in
      guard let data = data, let response = response as? HTTPURLResponse else {
        completion(nil, nil)
        return
      }
      completion(data, HTTPURLResponse.localizedString(forStatusCode: response.statusCode))
    }
    
    print("2")
    task.resume()
  }
}
