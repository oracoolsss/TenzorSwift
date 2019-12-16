//
//  NMPServices.swift
//  NYTClient
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import Foundation

class CloudImageService2 {
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

class CacheImageService {
  private func setupImageCache() -> URL {
    let fileManager = FileManager.default
    var cachesDir = try! fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    cachesDir.appendPathComponent("ImagesCache")
    if !fileManager.fileExists(atPath: cachesDir.path) {
      try! fileManager.createDirectory(at: cachesDir, withIntermediateDirectories: true, attributes: nil)
    }
    return cachesDir
  }
  
  private func generateImageName(url: URL) -> String {
    return "\(url.lastPathComponent)"
  }
  
  private func saveImageToCache(url: URL, data: Data) {
    let fileManager = FileManager.default
    var cachesDir = setupImageCache()
    cachesDir.appendPathComponent(generateImageName(url: url))
    
    fileManager.createFile(atPath: cachesDir.path, contents: data, attributes: nil)
  }
  
  func tryLoadImageFromCache(url: URL) -> Data? {
    let fileManager = FileManager.default
    var cachesDir = setupImageCache()
    cachesDir.appendPathComponent(generateImageName(url: url))
    return fileManager.contents(atPath: cachesDir.path)
  }
}
