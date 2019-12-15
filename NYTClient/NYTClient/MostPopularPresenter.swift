//
//  MostPopularPresenter.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

protocol MostPopularView: class {
  func display(viewModel: [SectionViewModel])
}

class MostPopularPresenter {
  weak var view: MostPopularView?
  
  private let cloudImageService = CloudImageService()
  private let mostPopularService = MostPopularService()
  
  init(view: MostPopularView) {
    
  }
}

//extension
