//
//  NMPViewModel.swift
//  NYTClient
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

struct CellViewModel2 {
  let text: String
  let imageSubscription: ImageSubscription2
}

struct SectionViewModel2 {
  let headerText: String
  let footerText: String
  let cells: [CellViewModel2]
}

typealias ImageSetter2 = ((UIImage, String)->Void)

class ImageSubscription2 {
  private var imageSetter: ImageSetter2? = nil
  
  func subscribe(_ closure: @escaping ImageSetter2) {
    imageSetter = closure
  }
  
  func set(_ image: UIImage, status: String) {
    imageSetter?(image, status)
  }
}
