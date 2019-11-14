//
//  ImageListViewController.swift
//  LectionUIKitTest
//
//  Created by Гость on 12/11/2019.
//  Copyright © 2019 Konstantin Polin. All rights reserved.
//

import UIKit

private struct CellData {
  let image: UIImage?
  let text: String
}

private struct SectionData {
  let headerText: String
  let footerText: String
  let cells: [CellData]
}

class ImageListViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  
  private let cheImage = UIImage(named: "cheboxary.jpg")
  
  lazy private var sections: [SectionData] = [
    SectionData(headerText: "It's first section", footerText: "It's footer", cells: [
      CellData(image: cheImage, text: "It's first cell"),
      CellData(image: cheImage, text: "It's second cell"),
      ]),
    SectionData(headerText: "It's first section", footerText: "It's footer", cells: [
      CellData(image: cheImage, text: "Good"),
      CellData(image: cheImage, text: "Buy"),
      CellData(image: cheImage, text: "America"),
      ]),
    SectionData(headerText: "It's first section", footerText: "It's footer", cells: [
      CellData(image: cheImage, text: "Hello"),
      CellData(image: cheImage, text: "Table"),
      CellData(image: cheImage, text: "View"),
      CellData(image: cheImage, text: "And"),
      CellData(image: cheImage, text: "World")
      ])
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    view.backgroundColor = .lightGray
    tableView.backgroundColor = .gray
    
    tableView.tableFooterView = UIView(frame: .zero)
  }
}

extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].headerText
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let label = UILabel(frame: .zero)
    label.text = sections[section].footerText
    label.backgroundColor = .darkGray
    
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


private class TableCell: UITableViewCell {
  private let previewImageView: UIImageView = UIImageView()
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
    previewImageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(imageNameLabel)
    contentView.addSubview(previewImageView)
    
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: previewImageView.leftAnchor),
      contentView.rightAnchor.constraint(equalTo: imageNameLabel.rightAnchor),
      contentView.topAnchor.constraint(equalTo: imageNameLabel.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: imageNameLabel.bottomAnchor),
      contentView.heightAnchor.constraint(equalToConstant: 80.0),
      
      previewImageView.rightAnchor.constraint(equalTo: imageNameLabel.leftAnchor, constant: -5.0),
      previewImageView.widthAnchor.constraint(equalToConstant: 70.0),
      previewImageView.heightAnchor.constraint(equalToConstant: 70.0),
      previewImageView.topAnchor.constraint(equalTo: imageNameLabel.topAnchor, constant: 5)
      ])
  }
  
  func configure(data: CellData) {
    imageNameLabel.text = data.text
    previewImageView.image = data.image
  }
}
