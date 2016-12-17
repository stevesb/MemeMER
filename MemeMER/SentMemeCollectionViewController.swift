//
//  sentMemeCollectionViewController.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/13/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SentMemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes = memes
//        memes = appDelegate.memes  Throws an error
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.memeImage.image = memes[indexPath.item].memedImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space:CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space)) / 3
        let height = view.frame.size.height / 5.5
        return CGSize(width: width, height: height)
    }

}








