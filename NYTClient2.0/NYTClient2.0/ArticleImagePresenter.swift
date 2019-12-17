//
//  ArticleImagePresenter.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class ArticleImagePresenter {
  private let cloudService = CloudImageService()
  
  func onViewDidLoad(articles: [ViewedArticle]) -> [ImageSubscription]{
    //let kittyURLs = UserDefaults.standard.object(forKey: "kittyURLs") as! [String]
    
    let subscriptions = presentViewModel(articlesCount: articles.count)
    loadImages(articles: articles, subscriptions: subscriptions)
    return subscriptions
  }
  
  private func presentViewModel(articlesCount: Int) -> [ImageSubscription] {
    
    var subscriptions = [ImageSubscription]()
    for i in 0..<articlesCount {
      let subscription = ImageSubscription()
      subscriptions.append(subscription)
    }
    
    //view?.display()
    
    return subscriptions
  }
  
  private func loadImages(articles: [ViewedArticle], subscriptions: [ImageSubscription]) {
    assert(articles.count == subscriptions.count, "Что то пошло не так")
    
    for i in stride(from: 0, to: articles.count, by: 1) {
      guard let articleUrl = URL(string: articles[i].media[0].mediaMetadata[0].url) else {
        assertionFailure("Неправильный урл")
        continue
      }
      let subscription = subscriptions[i]
      
      cloudService.loadImageFromCloud(url: articleUrl) { (data, status) in
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
