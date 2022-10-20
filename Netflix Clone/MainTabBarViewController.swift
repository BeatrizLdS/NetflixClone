//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 25/08/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let upcommingViewController = UINavigationController(rootViewController: UpcommingViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let downloadViewController = UINavigationController(rootViewController: DownloadsViewController())
        
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        homeViewController.title = "Home"
        
        upcommingViewController.tabBarItem.image = UIImage(systemName: "play.circle")
        upcommingViewController.title = "Comming Soon"
        
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchViewController.title = "Top Searches"
        
        downloadViewController.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        downloadViewController.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeViewController, upcommingViewController, searchViewController, downloadViewController], animated: true)
    }


}

