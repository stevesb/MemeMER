//
//  DetailViewController.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/17/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme: Meme!
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "MemeMER"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor.red
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    func editButtonTapped() {
        let controller = present(MemeEditorController(), animated: true, completion: nil)

    }
    
}





