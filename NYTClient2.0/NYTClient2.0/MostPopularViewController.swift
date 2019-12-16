//
//  ViewController.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class MostPopularViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var tableView = UITableView()
  let identifire = "mpCell"
  
  var mvArticles: [ViewedArticle] = []
  let mpService = MostPopularService()
  
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
    mpService.getMostPopular() { results, errMessage in
      if let results = results {
        self.mvArticles = results
        self.tableView.reloadData()
        print(self.mvArticles[0].abstract)
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
      }
      if !errMessage!.isEmpty { print("Search error: " + errMessage!) }
    }
    
    view.addSubview(tableView)
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
  
  

}

