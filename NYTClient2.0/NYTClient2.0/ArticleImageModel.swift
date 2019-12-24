//
//  ArticleImageModel.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

typealias ImageSetter = ((UIImage, String)->Void)

class ImageSubscription {
  private var imageSetter: ImageSetter? = nil
  
  func subscribe(_ closure: @escaping ImageSetter) {
    imageSetter = closure
  }
  
  func set(_ image: UIImage, status: String) {
    imageSetter?(image, status)
  }
}
