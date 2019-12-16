//
//  NMPPresenter.swift
//  NYTClient
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

protocol ImageListView: class {
  func display(viewModel: [SectionViewModel2])
}

class ImageListPresenter {
  weak private var view: ImageListView?
  
  private let cloudService = CloudImageService2()
  private let cacheService = CacheImageService()
  
  init(view: ImageListView) {
    self.view = view
  }
  
  func onViewDidLoad() {
    let kittyURLs = UserDefaults.standard.object(forKey: "kittyURLs") as! [String]
    
    let subscriptions = presentViewModel(cellsCount: kittyURLs.count)
    loadKitties(urls: kittyURLs, subscriptions: subscriptions)
  }
  
  private func presentViewModel(cellsCount: Int) -> [ImageSubscription2] {
    
    var subscriptions = [ImageSubscription2]()
    var cells = [CellViewModel2]()
    for i in 0..<cellsCount {
      let subscription = ImageSubscription2()
      let cellData = CellViewModel2(text: "cell \(i)", imageSubscription: subscription)
      subscriptions.append(subscription)
      cells.append(cellData)
    }
    
    view?.display(viewModel: [SectionViewModel2(headerText: "Kitties", footerText: "", cells: cells)])
    
    return subscriptions
  }
  
  private func loadKitties(urls: [String], subscriptions: [ImageSubscription2]) {
    print("buuu")
    assert(urls.count == subscriptions.count, "Что то пошло не так")
    
    for i in stride(from: 0, to: urls.count, by: 1) {
      guard let kittyUrl = URL(string: urls[i]) else {
        assertionFailure("Неправильный урл")
        continue
      }
      let subscription = subscriptions[i]
      
      if let imageData = cacheService.tryLoadImageFromCache(url: kittyUrl), let image = UIImage(data: imageData) {
        DispatchQueue.main.async {
          subscription.set(image, status: "Loaded from cache")
        }
        continue
      }
      
      cloudService.loadImageFromCloud(url: kittyUrl) { (data, status) in
        print("2 buu")
        guard let data = data, let status = status else {
          return
        }
        if let image = UIImage(data: data) {
          subscription.set(image, status: status)
        }
      }
    }
  }
  
}
