//
//  NMPViewController.swift
//  NYTClient
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController, ImageListView {
  //@IBOutlet var tableView: UITableView!
  var tableView = UITableView()
  
  private var sections = [SectionViewModel2]()
  
  private var presenter: ImageListPresenter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    //self.tableView.delegate = self
    self.tableView.dataSource = self
    
    
    view.backgroundColor = .lightGray
    self.tableView.backgroundColor = .yellow
    
    self.tableView.tableFooterView = UIView(frame: .zero)
    
    presenter = ImageListPresenter(view: self)
    presenter.onViewDidLoad()
    
    view.addSubview(self.tableView)
    
    var tabBarItem = UITabBarItem()
    tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 3)
    self.tabBarItem = tabBarItem
    self.title = "Most popular"
    
    self.tableView = UITableView(frame: view.bounds, style: .plain)
    self.tableView.delegate = self
    
    view.addSubview(tableView)
  }
  
  func display(viewModel: [SectionViewModel2]) {
    sections = viewModel
  }
}



extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].headerText
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
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
    
    return TableCell2()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let data = sections[indexPath.section].cells[indexPath.row]
    if let tableCell = cell as? TableCell2 {
      tableCell.configure(data: data)
    }
  }
}


private class TableCell2: UITableViewCell {
  private let preview: UIImageView = UIImageView(image: nil)
  private let imageNameLabel: UILabel = UILabel(frame: .zero)
  
  init() {
    super.init(style: .default, reuseIdentifier: nil)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    imageNameLabel.translatesAutoresizingMaskIntoConstraints = false
    preview.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(imageNameLabel)
    contentView.addSubview(preview)
    
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: preview.leftAnchor),
      contentView.centerYAnchor.constraint(equalTo: preview.centerYAnchor),
      preview.heightAnchor.constraint(equalToConstant: 70.0),
      preview.widthAnchor.constraint(equalToConstant: 70.0),
      
      imageNameLabel.leftAnchor.constraint(equalTo: preview.rightAnchor),
      contentView.rightAnchor.constraint(equalTo: imageNameLabel.rightAnchor),
      contentView.topAnchor.constraint(equalTo: imageNameLabel.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: imageNameLabel.bottomAnchor),
      contentView.heightAnchor.constraint(equalToConstant: 80.0)
      ])
    
    preview.layer.cornerRadius = 5
    preview.clipsToBounds = true
  }
  
  func configure(data: CellViewModel2) {
    imageNameLabel.text = data.text
    
    data.imageSubscription.subscribe { [weak self] (image, status) in
      self?.preview.image = image
      self?.imageNameLabel.text = status
      
    }
  }
}
