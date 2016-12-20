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

        setupControllers()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(noMemeLabel)
        noMemeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive =  true
        noMemeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noMemeLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        if memes.count == 0 {
            noMemeLabel.isHidden = false
        } else {
            noMemeLabel.isHidden = true
        }
        
        viewControllers?[0].viewWillAppear(true)
        viewControllers?[1].viewWillAppear(true)
    }
    
    func addButtonTapped() {
        let memeNavigationController = UINavigationController(rootViewController: MemeEditorController())
        present(memeNavigationController, animated: true, completion: nil)
    }
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    let noMemeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You have not created any meme yet! To create one use the plus sign!"
        label.numberOfLines = 2
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.font = UIFont(name: "Palatino-Italic", size: 18)
        return label
    }()
    
    func setupControllers() {

        UITabBar.appearance().tintColor = UIColor.black
        
        let tableController = SentMemeTableViewController()
        let tableNavigationController = UINavigationController(rootViewController: tableController)
        tableController.navigationItem.title = "Sent Memes"
        tableController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        tableController.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        tableNavigationController.tabBarItem.image = UIImage(named: "tableViewButton")
        tableNavigationController.tabBarItem.badgeColor = UIColor.black
        
        let layout = UICollectionViewFlowLayout()
        let collectionController = SentMemeCollectionViewController(collectionViewLayout: layout)
        let collectionNavigationController = UINavigationController(rootViewController: collectionController)
        collectionController.navigationItem.title = "Sent Memes"
        collectionController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        collectionController.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        collectionNavigationController.tabBarItem.image = UIImage(named: "collectionViewButton")
        
        viewControllers = [tableNavigationController, collectionNavigationController]
    }

}
