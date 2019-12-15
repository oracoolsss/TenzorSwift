//
//  RSSViewController.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class RSSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      let tabBarItem = UITabBarItem(title: "RSS", image: nil, tag: 1)
        //UITabBarItem(tabBarSystemItem: .recents, tag: 1)
      
      self.tabBarItem = tabBarItem
      self.title = "RSS"
    }
  

}
