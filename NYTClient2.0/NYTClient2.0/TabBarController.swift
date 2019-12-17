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
    
    //TODO: function
    let mpForDayViewController = MostPopularViewController()
    let mpForDayNavigationController = UINavigationController(rootViewController: mpForDayViewController)
    mpForDayNavigationController.tabBarItem.title = "MP4DAY"
    
    let mpForWeekViewController = MPForWeekViewController()
    let mpForWeekNavigationController = UINavigationController(rootViewController: mpForWeekViewController)
    mpForWeekNavigationController.tabBarItem.title = "MP4WEEK"
    
    
    viewControllers = [mpForDayNavigationController, mpForWeekNavigationController]
  }
  
  
}
