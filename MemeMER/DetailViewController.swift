//
//  DetailViewController.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/17/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var memeToEdit: Meme?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "MemeMER"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        if let meme = memeToEdit{
            imageView.image = meme.memedImage
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        let toolbar = navigationController?.toolbar
        toolbar?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        let controller = MemeEditorController()
        controller.fromDetail = true
        controller.meme = memeToEdit
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
