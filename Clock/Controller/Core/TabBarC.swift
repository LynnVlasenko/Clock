//
//  TabBarC.swift
//  Clock
//
//  Created by Алина Власенко on 31.01.2023.
//

import UIKit

class TabBarC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: WorldTimeVC())
        let vc2 = UINavigationController(rootViewController: AlarmVC())
        let vc3 = UINavigationController(rootViewController: StopWatchVC())
        let vc4 = UINavigationController(rootViewController: TimerVC())
        
        vc1.tabBarItem.image = UIImage(systemName: "globe")
        vc2.tabBarItem.image = UIImage(systemName: "alarm.fill")
        vc3.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        vc4.tabBarItem.image = UIImage(systemName: "timer")
        
        vc1.title = "Світовий час"
        vc2.title = "Будильник"
        vc3.title = "Секундомір"
        vc4.title = "Таймер"
        
        tabBar.tintColor = .systemOrange
        tabBar.unselectedItemTintColor = .systemGray
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    

}
