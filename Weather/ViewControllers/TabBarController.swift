//
//  TabBarController.swift
//  Weather
//
//  Created by Артём Тюрморезов on 09.11.2022.
//

import UIKit

class TabBarController: UITabBarController  {
    private let mainController: UINavigationController = {
        let vc = UINavigationController(rootViewController: ViewController())
        vc.tabBarItem.image = UIImage(systemName: "house")
        return vc
    }()
    private let tableController: UINavigationController = {
        let vc = UINavigationController(rootViewController: ViewWithTableViewController())
        vc.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        return vc
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white.withAlphaComponent(0.5)
        tabBar.tintColor = .white
        mainController.title = Res.setName.setName(.mainWeather)
        tableController.title = Res.setName.setName(.weatherList)
        tabBar.layer.cornerRadius = 10
        setViewControllers([mainController, tableController], animated: true)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

