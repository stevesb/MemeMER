//
//  TableViewCell.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/17/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

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
        label.adjustsFontSizeToFitWidth = true
        label.text = "ccc"
        return label
    }()
    
    func setupViews() {
        
        addSubview(memeImage)
        memeImage.heightAnchor.constraint(equalToConstant: 105).isActive = true
        memeImage.widthAnchor.constraint(equalToConstant: 105).isActive = true
        memeImage.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        memeImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        addSubview(memeLabel)
        memeLabel.leftAnchor.constraint(equalTo: memeImage.rightAnchor, constant: 10).isActive = true
        memeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        memeLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
