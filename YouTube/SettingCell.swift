//
//  SettingCell.swift
//  YouTube
//
//  Created by leanid niadzelin on 29.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting: Setting? {
        didSet {
            if let imageName = setting?.imageName {
                imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = .darkGray
            }
            titleLabel.text = setting?.titleName.rawValue
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? .lightGray : .white
            titleLabel.textColor = isHighlighted ? .white : .black
            imageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
