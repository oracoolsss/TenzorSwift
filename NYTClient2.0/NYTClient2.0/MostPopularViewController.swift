//
//  ViewController.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class MostPopularViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private var period = Int()
  
  var tableView = UITableView()
  let identifire = "mpCell"
  var refreshControl = UIRefreshControl()
  var mvArticles: [ViewedArticle] = []
  let mpService = MostPopularService()
  
  convenience init(period: Int) {
    self.init(nibName: nil, bundle: nil)
    self.period = period
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    refreshControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
    tableView.refreshControl = refreshControl
    createTable()
  }
  
  //this function is not working (maybe), progress: 40-50%/100%
  @objc func updateTable() {
    print("reloading data")
    createTable()
    refreshControl.endRefreshing()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mvArticles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = TableCell()
    cell.configure(article: mvArticles[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let articleUrl = URL(string: mvArticles[indexPath.row].url)
    UIApplication.shared.open(articleUrl!, options: [:], completionHandler: nil)
  }
  
}

extension MostPopularViewController {
  func createTable() {
    self.tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.register(TableCell.self, forCellReuseIdentifier: identifire)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    mpService.getMostPopular(period: period) { results, errMessage in
      if let results = results {
        self.mvArticles = results
        self.tableView.reloadData()
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
      }
      if !errMessage!.isEmpty { print("Search error: " + errMessage!) }
    }
    
    view.addSubview(tableView)
  }
}
