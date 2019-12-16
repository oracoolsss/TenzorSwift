//
//  MostPopularPresenter.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

protocol MostPopularView: class {
  func getMostPopularArticles() -> [ViewedArticle]
  func display(viewModel: [SectionViewModel])
}

class MostPopularPresenter {
  weak var view: MostPopularView?
  
  init(view: MostPopularView) {
    self.view = view
  }
  
  func onViewDidLoad() {
    let subscriptions = presentViewModel(articles: (view?.getMostPopularArticles())!)
    
  }
  
  func presentViewModel(articles: [ViewedArticle]) -> [ArticleSubscription] {
    var cells = [CellViewModel]()
    var subs = [ArticleSubscription]()
    
    for article in articles {
      let sub = ArticleSubscription()
      let cell = CellViewModel(title: article.title, abstract: article.abstract, imageSubscription: nil)
      cells.append(cell)
      subs.append(sub)
    }
    view?.display(viewModel: [SectionViewModel(headerText: "yee", footerText: "", cells: cells)])
    return subs
  }
  /*
  func getMostPopular(subscriptions: [ArticleSubscription]) {
  guard let data = data, let message = message else {
  return
  }
  self.mostPopularArticles = data
  print(message)
  print("mPA filled")
  ///print(self.mostPopularArticles[0].abstract)
  
  self.presenter = MostPopularPresenter(view: self)
  //presenter.on
  //self.sections = self.presenter.presentViewModel(articles: getMostPopularArticles())
  print(self.sections[0].cells[0].abstract)
  }
  */
}
