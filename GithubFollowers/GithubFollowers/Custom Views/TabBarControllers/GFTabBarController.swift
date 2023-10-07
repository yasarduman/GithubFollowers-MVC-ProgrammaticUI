//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 6.10.2023.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().backgroundColor = .quaternarySystemFill
        viewControllers          = [createSearchNC(), createFavoritesNC()]
    }
    
    // MARK: - Search Navigation Controller 🚀
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // MARK: - Favorites Navigation Controller 🌟
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC        = FavoritesListVC()
        favoritesListVC.title      = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
}
