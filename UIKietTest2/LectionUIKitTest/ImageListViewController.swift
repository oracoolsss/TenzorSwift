//
//  ImageListViewController.swift
//  LectionUIKitTest
//
//  Created by Гость on 12/11/2019.
//  Copyright © 2019 Konstantin Polin. All rights reserved.
//

import UIKit
//import Foundation

private struct CellData {
  //let image: UIImage?
  let text: String
  let imageSubscription: ImageSubscription
}

private struct SectionData {
  let headerText: String
  let footerText: String
  let cells: [CellData]
}

typealias ImageSetter = ((UIImage, Int) -> Void)

class ImageSubscription {
  private var imageSetter: ImageSetter? = nil
  
  func subscribe (_ closure: @escaping ImageSetter) {
    imageSetter = closure
  }
  
  func set(_ image: UIImage, status: Int) {
    imageSetter?(image, status)
  }
}

class ImageListViewController: UIViewController {
  
  /*
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
 */
  @IBOutlet var tableView: UITableView!
  
  @IBOutlet weak var imageView: UIImageView!
  
  private var sections = [SectionData]()
  
  private var urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.isHidden = true
    let gesture = UITapGestureRecognizer(target: self, action: #selector(oneTap(sender:)))

    imageView.addGestureRecognizer(gesture)
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    
    view.backgroundColor = .lightGray
    tableView.backgroundColor = .gray
    
    tableView.tableFooterView = UIView(frame: .zero)
    
    let kittySubscription = ImageSubscription()
    let roachSubscription = ImageSubscription()
    var animalSubscriptions = [ImageSubscription]()
    animalSubscriptions.append(kittySubscription)
    animalSubscriptions.append(roachSubscription)
    
    let animalCellData = [
      CellData(text: "kitty", imageSubscription: animalSubscriptions[0]),
      CellData(text: "roach)))", imageSubscription: animalSubscriptions[1])
    ]
    
    sections.append(SectionData(headerText: "Animals", footerText: "", cells: animalCellData))
    //sections.append(SectionData(headerText: "Faces", footerText: "", cells: facesCellData))
    
    let kittyUrl = URL(string: "https://sun9-55.userapi.com/c852232/v852232181/bc055/GumFgzYECK0.jpg")!
    let roachUrl = URL(string: "https://i.kym-cdn.com/entries/icons/original/000/030/917/cover1.jpg")!
    
    let task = urlSession.dataTask(with: kittyUrl) { (data, response, error) in
      guard let imageData = data, let image = UIImage(data: imageData) else {
        return
      }
      
      let httpResponse = response as! HTTPURLResponse
      
      animalSubscriptions[0].set(image, status: httpResponse.statusCode)
    }
    task.resume()
    
    let task2 = urlSession.dataTask(with: roachUrl) { (data, response, error) in
      guard let imageData = data, let image = UIImage(data: imageData) else {
        return
      }
      
      let httpResponse = response as! HTTPURLResponse
      
      animalSubscriptions[1].set(image, status: httpResponse.statusCode)
    }
    task2.resume()
  }
  
  @objc func oneTap(sender: UIGestureRecognizer) {
    imageView.isHidden = true
    tableView.isHidden = false
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
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let data = sections[indexPath.section].cells[indexPath.row]
    data.imageSubscription.subscribe {(image, status)  in
      self.imageView.image = image
    }
    print("\(data.text)")
    //let cheImage = UIImage(named:"cheboxary.jpg")
    //mageView.image = cheImage
    imageView.translatesAutoresizingMaskIntoConstraints = false
    tableView.isHidden = true
    imageView.isHidden = false
    //print("\(data.imageSubscription)")

  }
  
  @IBAction private func imageOnClick(_ sender: Any) {
    imageView.isHidden = true
    tableView.isHidden = false
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
    //previewImageView.image = data.image
    data.imageSubscription.subscribe {[weak self] (image, status)  in
      self?.previewImageView.image = image
    }
  }
  
}
