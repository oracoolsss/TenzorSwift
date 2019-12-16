//
//  TableViewModel.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

struct CellViewModel {
  let title: String
  let abstract: String
  let imageSubscription: ImageSubscription?
}

struct SectionViewModel {
  let headerText: String
  let footerText: String
  let cells: [CellViewModel]
}

typealias articleSetter = ((String, String) -> Void)

class ArticleSubscription {
  private var articleSetter: articleSetter? = nil
  
  func subscribe(_ closure: @escaping articleSetter) {
    articleSetter = closure
  }
  
  func set(title: String, abstract: String) {
    articleSetter?(title, abstract)
  }
}

//
/*
 typealias articleSetter = ((UIImage, String, String) -> Void)
 
 class ArticleSubscription {
 private var articleSetter: articleSetter? = nil
 
 func subscribe(_ closure: @escaping articleSetter) {
 articleSetter = closure
 }
 
 func set(_ image: UIImage, title: String, abstract: String) {
 articleSetter?(image, title, abstract)
 }
 }

 
 
 
 
 
 typealias ImageSetter = ((String)->Void)
 
 class ImageSubscription {
 private var imageSetter: ImageSetter? = nil
 
 func subscribe(_ closure: @escaping ImageSetter) {
 imageSetter = closure
 }
 
 func set(_ image: UIImage, status: String) {
 imageSetter?(image, status)
 }
 }
*/
typealias ImageSetter = ((String)->Void)

class ImageSubscription {
  private var imageSetter: ImageSetter? = nil
  
  func subscribe(_ closure: @escaping ImageSetter) {
    imageSetter = closure
  }
  
  func set(status: String) {
    imageSetter?(status)
  }
}
