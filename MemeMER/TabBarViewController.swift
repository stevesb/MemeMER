//
//  TabBarViewController.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/13/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tabBar.barTintColor = UIColor.lightGray
        UITabBar.appearance().tintColor = UIColor.black
        
        let tableController = SentMemeTableViewController()
        let tableNavigationController = UINavigationController(rootViewController: tableController)
        tableController.navigationItem.title = "Sent Memes"
        tableController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        tableController.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        tableNavigationController.navigationBar.barTintColor = UIColor.orange
        tableNavigationController.tabBarItem.image = UIImage(named: "tableViewButton")
        tableNavigationController.tabBarItem.badgeColor = UIColor.black
        
        let layout = UICollectionViewFlowLayout()
        let collectionController = SentMemeCollectionViewController(collectionViewLayout: layout)
        let collectionNavigationController = UINavigationController(rootViewController: collectionController)
        collectionController.navigationItem.title = "Sent Memes"
        collectionController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        collectionController.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        collectionNavigationController.navigationBar.barTintColor = UIColor.orange
        collectionNavigationController.tabBarItem.image = UIImage(named: "collectionViewButton")

        viewControllers = [tableNavigationController, collectionNavigationController]

    }
    
    func addButtonTapped() {
        let memeNavigationController = UINavigationController(rootViewController: MemeEditorController())
        present(memeNavigationController, animated: true, completion: nil)
    }

}
