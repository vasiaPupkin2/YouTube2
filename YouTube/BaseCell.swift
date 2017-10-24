//
//  BaseCell.swift
//  YouTube
//
//  Created by leanid niadzelin on 25.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        
    }
}
