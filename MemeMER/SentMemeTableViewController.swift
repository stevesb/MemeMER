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
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes = memes
        
        self.tableView.separatorStyle = .none
        tableView.rowHeight = 109
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes = memes
        
        tableView!.reloadData()
        
    }
    
    func addButtonTapped() {
        present(MemeEditorController(), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        cell.memeLabel.text = "\(memes[indexPath.item].topText)...\(memes[indexPath.item].bottomText)"
        cell.memeImage.image = memes[indexPath.item].memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMeme = memes[indexPath.item].memedImage
        let controller = DetailViewController()
        controller.memeToEdit = memes[indexPath.item]
        navigationController?.pushViewController(controller, animated: true)
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backBtn))
        
    }
    
    func backBtn() {
        let controller = TabBarController()
        present(controller, animated: true, completion: nil)
    }
}
