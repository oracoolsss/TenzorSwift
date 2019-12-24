//
//  MostViewedCell.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
  private let imagePreview: UIImageView = UIImageView(image: nil)
  private let articleTitle: UILabel = UILabel(frame: .zero)
  private let articleAbstract: UILabel = UILabel(frame: .zero)
  private var toFullBotton: UIButton = UIButton(frame: .zero)
  private let infoAboutFull: UILabel = UILabel(frame: .zero)
  private var linkToFull: String?
  
  init() {
    super.init(style: .default, reuseIdentifier: nil)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    imagePreview.translatesAutoresizingMaskIntoConstraints = false
    articleTitle.translatesAutoresizingMaskIntoConstraints = false
    articleAbstract.translatesAutoresizingMaskIntoConstraints = false
    infoAboutFull.translatesAutoresizingMaskIntoConstraints = false
    toFullBotton.translatesAutoresizingMaskIntoConstraints = false
    
    articleTitle.numberOfLines = 0
    articleAbstract.numberOfLines = 0
    infoAboutFull.numberOfLines = 0
    articleTitle.font = UIFont.boldSystemFont(ofSize: articleAbstract.font.pointSize + 3)
    infoAboutFull.font = UIFont.boldSystemFont(ofSize: articleAbstract.font.pointSize)
    infoAboutFull.text = "Click to view full article in browser (without CheboxarIb)"
    toFullBotton.setTitle("View full article", for: .normal)
    toFullBotton.setTitleColor(UIColor.black, for: .normal)
    
    contentView.addSubview(imagePreview)
    contentView.addSubview(articleTitle)
    contentView.addSubview(articleAbstract)
    contentView.addSubview(infoAboutFull)
    
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: imagePreview.leftAnchor),
      contentView.leftAnchor.constraint(equalTo: imagePreview.leftAnchor),
      contentView.topAnchor.constraint(equalTo: imagePreview.topAnchor),
      imagePreview.heightAnchor.constraint(equalToConstant: 90.0),
      imagePreview.widthAnchor.constraint(equalToConstant: 90.0),
      articleTitle.leftAnchor.constraint(equalTo: imagePreview.rightAnchor, constant: 10),
      articleAbstract.leftAnchor.constraint(equalTo: imagePreview.rightAnchor, constant: 10),
      articleAbstract.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      articleTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      articleTitle.bottomAnchor.constraint(equalTo: articleAbstract.topAnchor),
      contentView.topAnchor.constraint(equalTo: articleTitle.topAnchor),
      infoAboutFull.topAnchor.constraint(equalTo: articleAbstract.bottomAnchor),
      infoAboutFull.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      infoAboutFull.leftAnchor.constraint(equalTo: imagePreview.rightAnchor, constant: 10),
      infoAboutFull.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120.0)
      ])
    
    imagePreview.clipsToBounds = true
  }
  
  func configure(article: ViewedArticle) {
    articleTitle.text = article.title
    articleAbstract.text = article.abstract
    imagePreview.image = UIImage(named: "cheboxary.jpg")
    linkToFull = article.url
  }
  
  func configure() {
    articleTitle.text = "test article"
    articleAbstract.text = "test abstract"
    imagePreview.image = UIImage(named: "cheboxary.jpg")
  }
}

