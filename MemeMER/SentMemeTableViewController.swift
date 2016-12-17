//
//  sentMemeTableViewController.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/13/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {

    private var cellId = "reuseIdentifier"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        memes = appDelegate.memes
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
        
    }
    
    func addButtonTapped() {
        present(MemeEditorController(), animated: true, completion: nil)
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return memes.count
//    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        cell.memeLabel.text = "\(memes[indexPath.item].topText)...\(memes[indexPath.item].bottomText)"
        cell.memeImage.image = memes[indexPath.item].memedImage
        cell.backgroundColor = UIColor.blue

        return cell
    }

}

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let memeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.black
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "collectionViewButton")
        return imageView
    }()
    
    let memeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ccc"
        return label
    }()
    
    func setupViews() {
        addSubview(memeImage)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0](50)|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": memeImage]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": memeImage]))
        addSubview(memeLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-60-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": memeLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": memeLabel]))
        
    }
}


