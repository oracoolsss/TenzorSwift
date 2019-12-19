//
//  MPForWeekViewController.swift
//  NYTClient2.0
//
//  Created by oracool on 17/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class MPForWeekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private let period = 7
  
  var tableView = UITableView()
  let identifire = "mpCell"
  
  var mvArticles: [ViewedArticle] = []
  let mpService = MostPopularService()
  var subs = [ImageSubscription]()
  
  private var presenter: ArticleImagePresenter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createTable()
    
  }
  
  func createTable() {
    self.tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.register(TableCell.self, forCellReuseIdentifier: identifire)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    mpService.getMostPopular(period: period) { results, errMessage in
      if let results = results {
        self.mvArticles = results
        
        self.tableView.reloadData()
        print(self.mvArticles[0].abstract)
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
      }
      if !errMessage!.isEmpty { print("Search error: " + errMessage!) }
    }
    //presenter = ArticleImagePresenter()
    //subs = presenter.onViewDidLoad(articles: mvArticles)
    print(mvArticles.count)
    print(subs.count)
    view.addSubview(tableView)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //return 3
    return mvArticles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //let data = subs[indexPath.row]
    let cell = TableCell()
    cell.configure(article: mvArticles[indexPath.row])
    return cell
    
  }
  
  
  
}

