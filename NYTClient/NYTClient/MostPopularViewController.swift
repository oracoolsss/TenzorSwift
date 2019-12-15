//
//  MostPopularViewController.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class MostPopularViewController: UIViewController, UITableViewDelegate {
  
  var tableView = UITableView()
  
  var mostPopularArticles: [ViewedArticle] = []
  let mostPopularService = MostPopularService()
  let cloudImageService = CloudImageService()
  
  private var sections = [SectionViewModel]()
  private var presenter: MostPopularPresenter!
  

    override func viewDidLoad() {
        super.viewDidLoad()
      //
      setView()
      
      var tabBarItem = UITabBarItem()
      tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
      self.tabBarItem = tabBarItem
      self.title = "Most popular"
      
      self.tableView = UITableView(frame: view.bounds, style: .plain)
      self.tableView.delegate = self
      
      view.addSubview(tableView)
    }

  
}

extension MostPopularViewController {
  private func setView() {
    mostPopularService.getMostPopular() {viewedArticles, errorMessage in
      if let articles = viewedArticles {
        self.mostPopularArticles = articles
        self.tableView.reloadData()
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
      }
      if !errorMessage.isEmpty { print("error: " + errorMessage) }
    }
  }
}

extension MostPopularViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].headerText
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let label = UILabel(frame: .zero)
    //label.text = sections[section].footerText
    label.backgroundColor = .red
    
    return label
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // indexPath.row
    // indexPath.section
    
    return TableCell()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let data = sections[indexPath.section].cells[indexPath.row]
    if let tableCell = cell as? TableCell {
      tableCell.configure(data: data)
    }
  }
}


