//
//  ViewController.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    var tabBarItem = UITabBarItem()
    tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
    self.tabBarItem = tabBarItem
    self.title = "test"
  }


}

