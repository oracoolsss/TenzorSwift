//
//  TabBarController.swift
//  NYTClient2.0
//
//  Created by oracool on 17/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = getNavControllers(periods: [1, 7, 30])
  }
  
  private func getNavControllers(periods: [Int]) -> [UINavigationController] {
    var navControllers: [UINavigationController] = []
    for period in periods {
      let mpViewController = MostPopularViewController(period: period)
      let mpNavController = UINavigationController(rootViewController: mpViewController)
      mpNavController.tabBarItem.title = "MP4\(period)DAY\(period == 1 ? "" : "s")"
      navControllers.append(mpNavController)
    }
    return navControllers
  }
  
  
}
