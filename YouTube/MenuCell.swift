//
//  MenuCell.swift
//  YouTube
//
//  Created by leanid niadzelin on 25.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
