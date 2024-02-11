//
//  ViewController.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 06.02.24.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        generateTabBar()
        setupTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HomeViewController(), title: "Home", image: UIImage(systemName: "house.fill")!),
            generateVC(viewController: DiscoverViewController(), title: "Discover", image: UIImage(systemName: "location.north.circle.fill")!),
            generateVC(viewController: ComingSoonViewController(), title: "Coming Soon", image: UIImage(systemName: "play.circle.fill")!),
            generateVC(viewController: DownloadsViewController(), title: "Downloads", image: UIImage(systemName: "arrow.down")!)
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let nav = UINavigationController(rootViewController: viewController)
        return nav
    }
    
    private func setupTabBar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().tintColor = UIColor.red
    }
}

