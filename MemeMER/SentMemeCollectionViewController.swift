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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes = memes
//        memes = appDelegate.memes   throws an  error
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
        
    }
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
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

class MemeCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(memeImage)
        memeImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        memeImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        memeImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        memeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    let memeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






