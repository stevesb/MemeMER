//
//  CustomCollectionViewCell.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/16/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(memeImage)
        memeImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        memeImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        memeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
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
