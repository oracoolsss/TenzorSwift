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
    
    articleTitle.numberOfLines = 0
    articleAbstract.numberOfLines = 0
    articleTitle.font = UIFont.boldSystemFont(ofSize: articleAbstract.font.pointSize)
    
    contentView.addSubview(imagePreview)
    contentView.addSubview(articleTitle)
    contentView.addSubview(articleAbstract)
    
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: imagePreview.leftAnchor),
      contentView.centerYAnchor.constraint(equalTo: imagePreview.centerYAnchor),
      imagePreview.heightAnchor.constraint(equalToConstant: 90.0),
      imagePreview.widthAnchor.constraint(equalToConstant: 90.0),
      articleAbstract.leftAnchor.constraint(equalTo: imagePreview.rightAnchor),
      articleTitle.leftAnchor.constraint(equalTo: imagePreview.rightAnchor),
      
      articleAbstract.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      articleTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      articleTitle.bottomAnchor.constraint(equalTo: articleAbstract.topAnchor),
      contentView.topAnchor.constraint(equalTo: articleTitle.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: articleAbstract.bottomAnchor),
      //contentView.heightAnchor.constraint(equalToConstant: 100.0)
      contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0)
      ])
    
    imagePreview.clipsToBounds = true
  }
  
  func configure(article: ViewedArticle, data: ImageSubscription) {
    articleTitle.text = article.title
    articleAbstract.text = article.abstract
    
     data.subscribe { [weak self] (title, abstract)  in
     self?.imagePreview.image = nil
     }
    
  }
  
  func configure(article: ViewedArticle) {
    articleTitle.text = article.title
    articleAbstract.text = article.abstract
    imagePreview.image = UIImage(named: "cheboxary.jpg")
  }
  
  func configure() {
    articleTitle.text = "test article"
    articleAbstract.text = "test abstract"
    imagePreview.image = UIImage(named: "cheboxary.jpg")
  }
}

