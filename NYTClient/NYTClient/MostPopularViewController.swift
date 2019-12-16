//
//  MostPopularViewController.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class MostPopularViewController: UIViewController, UITableViewDelegate, MostPopularView {
  func getMostPopularArticles() -> [ViewedArticle] {
    return mostPopularArticles
  }
  
  var tableView = UITableView()
  
  var mostPopularArticles: [ViewedArticle] = []
  let mostPopularService = MostPopularService()
  let cloudImageService = CloudImageService()
  
  private var sections = [SectionViewModel]()
  private var presenter: MostPopularPresenter!
  
  

    override func viewDidLoad() {
        super.viewDidLoad()
      //
      
      var tabBarItem = UITabBarItem()
      tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
      self.tabBarItem = tabBarItem
      self.title = "Most popular"
      
      self.tableView = UITableView(frame: view.bounds, style: .plain)
      self.tableView.delegate = self
      
      view.addSubview(tableView)
      
      presenter = MostPopularPresenter(view: self)
      //presenter.on
      //sections = presenter.presentViewModel(articles: getMostPopularArticles())
      //print(sections[0].cells[0].abstract)
      
    }
  func display(viewModel: [SectionViewModel]) {
    sections = viewModel
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
    label.text = sections[section].footerText
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
    
    //let cell: TableCell = tableView.dequeueReusableCell(for: indexPath)
    
    
    // Delegate cell button tap events to this view controller
    
    //let track = searchResults[indexPath.row]
    //cell.configure(data: CellViewModel(title: mostPopularArticles[indexPath.row].title, abstract: mostPopularArticles[indexPath.row].abstract, imageSubscription: nil))
    
    //return cell
    
    return TableCell()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let data = sections[indexPath.section].cells[indexPath.row]
    if let tableCell = cell as? TableCell {
      tableCell.configure(data: data)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let track = mostPopularArticles[indexPath.row]
    tableView.deselectRow(at: indexPath, animated: true)
  }
}



